import 'package:flutter/material.dart';

// 1. Updated the field object to accept a default assignee dynamically
class ExtraCostField {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String assignedTo;

  ExtraCostField({required this.assignedTo});

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

class AttachReceiptScreen extends StatefulWidget {
  const AttachReceiptScreen({super.key});

  @override
  State<AttachReceiptScreen> createState() => _AttachReceiptScreenState();
}

class _AttachReceiptScreenState extends State<AttachReceiptScreen> {
  final TextEditingController _baseBillController = TextEditingController();
  final List<ExtraCostField> _extraCostFields = [];

  // Variables to hold the routing data and dynamic dropdown options
  late List<String> _participants;
  late String _splitMethod;
  late List<String> _assignOptions;
  late String _defaultAssignee;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 2. We initialize the data here so the dropdown knows what to display immediately
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
          {};
      _participants = args['participants'] ?? [];
      _splitMethod = args['method'] ?? 'Equal';

      // LOGIC UPGRADE: If Itemized, remove 'Everyone' from the options.
      if (_splitMethod == 'Itemized') {
        _assignOptions = [..._participants];
      } else {
        _assignOptions = ['Everyone', ..._participants];
      }

      // Safety fallback if the participant list somehow comes in empty
      _defaultAssignee = _assignOptions.isNotEmpty
          ? _assignOptions.first
          : 'Unknown';
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _baseBillController.dispose();
    for (var field in _extraCostFields) {
      field.dispose();
    }
    super.dispose();
  }

  // --- MOCK SCANNER LOGIC ---
  Future<void> _scanReceipt() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF2563EB)),
            SizedBox(height: 16),
            Text(
              "Scanning receipt...",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Extracting total amount...",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) Navigator.pop(context);

    setState(() {
      _baseBillController.text = "145000";
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Receipt scanned successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // 3. Spawns a new field, defaulting to 'Everyone' or the first Participant
  void _addNewExtraField() {
    final newField = ExtraCostField(assignedTo: _defaultAssignee);
    newField.amountController.addListener(_updateTotal);
    setState(() {
      _extraCostFields.add(newField);
    });
  }

  void _removeExtraField(int index) {
    final field = _extraCostFields[index];
    field.amountController.removeListener(_updateTotal);
    field.dispose();
    setState(() {
      _extraCostFields.removeAt(index);
    });
  }

  void _updateTotal() {
    setState(() {}); // Triggers a rebuild to update the Grand Total
  }

  void _confirmAndReveal() {
    if (_baseBillController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter or scan the total bill amount"),
        ),
      );
      return;
    }

    final double baseBill =
        double.tryParse(_baseBillController.text.trim()) ?? 0.0;

    final List<Map<String, dynamic>> finalizedExtras = [];
    for (var field in _extraCostFields) {
      final name = field.nameController.text.trim();
      final amount = double.tryParse(field.amountController.text.trim()) ?? 0.0;

      if (name.isNotEmpty && amount > 0) {
        finalizedExtras.add({
          'name': name,
          'amount': amount,
          'assignedTo': field.assignedTo,
        });
      }
    }

    // Re-grab args to pass them forward
    final incomingArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};

    final Map<String, dynamic> updatedArgs = {
      ...incomingArgs,
      'baseBill': baseBill,
      'extras': finalizedExtras,
    };

    Navigator.pushNamed(context, '/pool-recap', arguments: updatedArgs);
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Total Calculation
    double totalExtras = _extraCostFields.fold(0, (sum, field) {
      return sum + (double.tryParse(field.amountController.text) ?? 0.0);
    });
    double baseBill = double.tryParse(_baseBillController.text) ?? 0.0;
    double grandTotal = baseBill + totalExtras;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Enter The Bill",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. CORE RECEIPT AMOUNT ---
                  const Text(
                    "Total Receipt Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _baseBillController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) => _updateTotal(),
                    decoration: InputDecoration(
                      hintText: "e.g. 150000",
                      prefixText: "UGX  ",
                      prefixStyle: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.document_scanner_outlined,
                          color: Color(0xFF2563EB),
                        ),
                        tooltip: "Scan Receipt",
                        onPressed: _scanReceipt,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF2563EB),
                          width: 2,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- 2. EXTRAS (DYNAMIC FIELDS) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Additional Costs",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _addNewExtraField,
                        icon: const Icon(
                          Icons.add,
                          size: 18,
                          color: Color(0xFF06B6D4),
                        ),
                        label: const Text(
                          "Add",
                          style: TextStyle(
                            color: Color(0xFF06B6D4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _splitMethod == 'Itemized'
                        ? "Manually assign tips or items to specific people."
                        : "Tips, Boda Boda, or manual item assignments.",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 16),

                  // Render the dynamic list of editable extra fields
                  ..._extraCostFields.asMap().entries.map((entry) {
                    int index = entry.key;
                    ExtraCostField field = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: field.nameController,
                                  decoration: const InputDecoration(
                                    hintText: "e.g. Boda Fee",
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: field.amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: "Amount",
                                    prefixText: "UGX ",
                                    isDense: true,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeExtraField(index),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            // Safety check to ensure the value actually exists in the options
                            value: _assignOptions.contains(field.assignedTo)
                                ? field.assignedTo
                                : _defaultAssignee,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: "Manual Assignment",
                            ),
                            items: _assignOptions.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(
                                  option,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() => field.assignedTo = newValue);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // --- 3. THE FOOTER (Grand Total & Reveal) ---
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Grand Total",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "UGX ${grandTotal.toInt()}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _confirmAndReveal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Confirm & Reveal Shares",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
