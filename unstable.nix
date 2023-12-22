{ config, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    eza
  ];
  fonts = {
    packages = with pkgs-unstable; [
      nerdfonts
      iosevka
      # (callPackage ./custom/iosevka.nix {})
      (iosevka.override {
        set = "pro";
        privateBuildPlan = ''
          [buildPlans.iosevka-pro]
          family = "Iosevka Pro"
          spacing = "normal"
          serifs = "sans"
          no-cv-ss = true
          export-glyph-names = true

          [buildPlans.iosevka-pro.variants]
          inherits = "ss08"

          [buildPlans.iosevka-pro.variants.design]
          zero = "diamond-dotted"
          two = "straight-neck"
          seven = "straight-serifless"
          eight = "two-circles"
          punctuation-dot = "round"
          asterisk = "hex-high"
          paren = "large-contour"
          brace = "straight"
          guillemet = "straight"
          ampersand = "closed"
          at = "fourfold-solid-inner"
          dollar = "open"
          bar = "force-upright"
          ascii-single-quote = "straight"
          ascii-grave = "straight"
          question = "smooth"
          lig-ltgteq = "flat"
          lig-neq = "slightly-slanted"
          lig-equal-chain = "with-notch"
          lig-hyphen-chain = "without-notch"
          lig-double-arrow-bar = "without-notch"
          lig-single-arrow-bar = "without-notch"

          [buildPlans.iosevka-pro.ligations]
          inherits = "dlig"

          [buildPlans.iosevka-pro.weights.regular]
          shape = 400
          menu = 400
          css = 400

          [buildPlans.iosevka-pro.weights.Bold]
          shape = 700
          menu = 700
          css = 700

          [buildPlans.iosevka-pro.widths.Normal]
          shape = 500
          menu = 5
          css = "normal"

          [buildPlans.iosevka-pro.widths.extended]
          shape = 600
          menu = 7
          css = "expanded"

          [buildPlans.iosevka-pro.slopes.upright]
          angle = 0
          shape = "upright"
          menu = "upright"
          css = "normal"

          [buildPlans.iosevka-pro.slopes.Italic]
          angle = 9.4
          shape = "italic"
          menu = "italic"
          css = "italic"
        '';
      })
      (iosevka.override {
        set = "basic";
        privateBuildPlan = ''
          [buildPlans.iosevka-basic]
          family = "Iosevka Basic"
          spacing = "normal"
          serifs = "sans"
          no-cv-ss = true
          export-glyph-names = true

          [buildPlans.iosevka-basic.variants.design]
          zero = "dotted"
          one = "no-base"
          two = "straight-neck"
          three = "two-arcs"
          four = "semi-open"
          five = "upright-arched"
          six = "closed-contour"
          seven = "straight-serifless"
          eight = "two-circles"
          nine = "closed-contour"
          punctuation-dot = "round"
          asterisk = "hex-high"
          ascii-grave = "straight"
          ascii-single-quote = "straight"
          paren = "large-contour"
          brace = "straight"
          guillemet = "straight"
          ampersand = "closed"
          at = "fourfold-solid-inner"
          dollar = "open"
          bar = "force-upright"
          question = "smooth"
          lig-ltgteq = "flat"
          lig-neq = "slightly-slanted"
          lig-equal-chain = "with-notch"
          lig-hyphen-chain = "without-notch"
          lig-double-arrow-bar = "without-notch"
          lig-single-arrow-bar = "without-notch"

          [buildPlans.iosevka-basic.ligations]
          inherits = "dlig"

          [buildPlans.iosevka-basic.weights.Regular]
          shape = 400
          menu = 400
          css = 400

          [buildPlans.iosevka-basic.weights.Bold]
          shape = 700
          menu = 700
          css = 700

          [buildPlans.iosevka-basic.widths.Normal]
          shape = 500
          menu = 5
          css = "normal"

          [buildPlans.iosevka-basic.widths.Extended]
          shape = 600
          menu = 7
          css = "expanded"

          [buildPlans.iosevka-basic.slopes.Upright]
          angle = 0
          shape = "upright"
          menu = "upright"
          css = "normal"

          [buildPlans.iosevka-basic.slopes.Italic]
          angle = 9.4
          shape = "italic"
          menu = "italic"
          css = "italic"
        '';
      })
    ];
  };
}
