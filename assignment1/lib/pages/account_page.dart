import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class AccountPage extends StatefulWidget {
  final UserProfile profile;
  final ValueChanged<UserProfile> onProfileUpdated;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const AccountPage({
    super.key,
    required this.profile,
    required this.onProfileUpdated,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  bool _orderNotifications = true;
  bool _promoAlerts = true;
  String _selectedLanguage = 'English (US)';
  String _dietaryPref = 'Non-Veg & Veg';

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _addressController = TextEditingController(text: widget.profile.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final updated = widget.profile.copyWith(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
    );
    widget.onProfileUpdated(updated);
    setState(() => _isEditing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text('Account details updated successfully!'),
          ],
        ),
        backgroundColor: Colors.deepPurple[700],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text('Logout Confirmation'),
          ],
        ),
        content: const Text('Are you sure you want to log out of FooddySpot?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'My Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                'Manage your profile, delivery addresses, and settings',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Profile Overview Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black26 : Colors.deepPurple.withValues(alpha: 0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.deepPurple, width: 2.5),
                          ),
                          child: CircleAvatar(
                            radius: 36,
                            backgroundImage: NetworkImage(widget.profile.avatarUrl),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.profile.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.profile.email,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Foodie Gold Member ⭐',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_isEditing)
                          IconButton(
                            onPressed: () => setState(() => _isEditing = true),
                            icon: const Icon(Icons.edit, color: Colors.deepPurple),
                            tooltip: 'Edit Profile',
                          ),
                      ],
                    ),
                    if (_isEditing) ...[
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 16),
                      _buildTextField('Full Name', _nameController, isDark, Icons.person_outline),
                      const SizedBox(height: 12),
                      _buildTextField('Email Address', _emailController, isDark, Icons.email_outlined),
                      const SizedBox(height: 12),
                      _buildTextField('Phone Number', _phoneController, isDark, Icons.phone_outlined),
                      const SizedBox(height: 12),
                      _buildTextField('Delivery Address', _addressController, isDark, Icons.location_on_outlined, maxLines: 2),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              _initControllers();
                              setState(() => _isEditing = false);
                            },
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _saveProfile,
                            icon: const Icon(Icons.check, size: 16),
                            label: const Text('Save Changes'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Saved Delivery Address Card
              _buildSectionCard(
                title: 'Saved Delivery Address',
                icon: Icons.location_on_rounded,
                isDark: isDark,
                child: Row(
                  children: [
                    const Icon(Icons.home_work_outlined, color: Colors.deepPurple, size: 28),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Default Home Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.profile.address,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isEditing = true),
                      child: const Text('Change', style: TextStyle(color: Colors.deepPurple)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Preferences & App Settings
              _buildSectionCard(
                title: 'App Preferences & Settings',
                icon: Icons.settings_rounded,
                isDark: isDark,
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: Icon(
                        widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: widget.isDarkMode ? Colors.amber : Colors.deepPurple,
                      ),
                      title: Text(
                        'Dark Theme Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Sleek dark theme for easy viewing at night',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      value: widget.isDarkMode,
                      activeThumbColor: Colors.deepPurple,
                      onChanged: widget.onDarkModeChanged,
                    ),
                    Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_active_outlined, color: Colors.deepPurple),
                      title: Text(
                        'Order Updates & Tracking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Get instant notifications when your meal is prepared and out for delivery',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      value: _orderNotifications,
                      activeThumbColor: Colors.deepPurple,
                      onChanged: (val) => setState(() => _orderNotifications = val),
                    ),
                    Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                    SwitchListTile(
                      secondary: const Icon(Icons.discount_outlined, color: Colors.orange),
                      title: Text(
                        'Promotional Offers & Vouchers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'Receive special discount alerts and weekend deals',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      value: _promoAlerts,
                      activeThumbColor: Colors.deepPurple,
                      onChanged: (val) => setState(() => _promoAlerts = val),
                    ),
                    Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.restaurant_menu, color: Colors.deepPurple),
                              const SizedBox(width: 14),
                              Text(
                                'Food Preference',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            value: _dietaryPref,
                            underline: const SizedBox(),
                            dropdownColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                            items: ['Non-Veg & Veg', 'Pure Veg', 'Vegan', 'Jain']
                                .map((pref) => DropdownMenuItem(value: pref, child: Text(pref)))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _dietaryPref = val);
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.language_rounded, color: Colors.deepPurple),
                              const SizedBox(width: 14),
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            value: _selectedLanguage,
                            underline: const SizedBox(),
                            dropdownColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                            items: ['English (US)', 'Spanish', 'Hindi', 'French']
                                .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedLanguage = val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logout Action Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _showLogoutDialog,
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Logout Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required bool isDark,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.deepPurple.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.deepPurple),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDark,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple, size: 20),
        filled: true,
        fillColor: isDark ? Colors.grey[900] : Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
