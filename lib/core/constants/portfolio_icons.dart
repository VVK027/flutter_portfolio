/// SVG icon asset paths used across the portfolio UI.
enum PortfolioIcons {
  linkedin('assets/icons/linkedin.svg'),
  github('assets/icons/github.svg'),
  pub('assets/icons/pub.svg'),
  facebook('assets/icons/facebook-f.svg'),
  whatsapp('assets/icons/whatsapp.svg');

  const PortfolioIcons(this.assetPath);
  final String assetPath;
}