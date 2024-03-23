import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/responsive.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determina se lo schermo è abbastanza ampio per un layout desktop
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    // Riduci il padding generale e regola il layout in base alla piattaforma
    double horizontalPadding = isDesktop ? 20 : 10;
    double verticalPadding = 10;
    double spacing = 8; // Spazio tra i testi e le icone

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      color: Colors.blueGrey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDesktop) ..._buildDesktopLayout(spacing),
          if (!isDesktop && !isMobile) ..._buildTabletLayout(spacing),
          if (isMobile) ..._buildMobileLayout(spacing),
          Padding(
            padding: EdgeInsets.only(top: spacing),
            child: Text(
              '© 2024 Azienda Fittizia S.p.A.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: isDesktop ? 12 : 10, // Riduci la dimensione del testo per il copyright
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDesktopLayout(double spacing) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCompanyInfo(spacing),
          _buildContactInfo(spacing),
          _buildSocialLinks(spacing),
        ],
      ),
    ];
  }

  List<Widget> _buildTabletLayout(double spacing) {
    return [
      Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: spacing, // Spazio orizzontale tra gli elementi
        runSpacing: spacing, // Spazio verticale tra le righe
        children: [
          _buildCompanyInfo(spacing),
          _buildContactInfo(spacing),
          _buildSocialLinks(spacing),
        ],
      ),
    ];
  }

  List<Widget> _buildMobileLayout(double spacing) {
    return [
      _buildCompanyInfo(spacing),
      SizedBox(height: spacing),
      _buildContactInfo(spacing),
      SizedBox(height: spacing),
      _buildSocialLinks(spacing),
    ];
  }

  Widget _buildCompanyInfo(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Azienda Fittizia S.p.A.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: spacing),
        Text('Via Roma, 1', style: TextStyle(color: Colors.white)),
        SizedBox(height: spacing),
        Text('00100 Roma', style: TextStyle(color: Colors.white)),
        SizedBox(height: spacing),
        Text('P.IVA 0123456789', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildContactInfo(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contatti', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: spacing),
        Text('info@aziendafittizia.com', style: TextStyle(color: Colors.white)),
        SizedBox(height: spacing),
        Text('+39 012 3456789', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildSocialLinks(double spacing) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.facebook, color: Colors.white),
          onPressed: () {},
        ),
        SizedBox(width: spacing),
        IconButton(
          icon: Icon(FontAwesomeIcons.twitter, color: Colors.white),
          onPressed: () {},
        ),
        SizedBox(width: spacing),
        IconButton(
          icon: Icon(FontAwesomeIcons.instagram, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
