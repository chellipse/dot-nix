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
        set = "custom";
        privateBuildPlan = ''
          [buildPlans.iosevka-custom]
          family = "Iosevka Pro"
          spacing = "normal"
          serifs = "sans"
          no-cv-ss = true
          export-glyph-names = true

          [buildPlans.iosevka-custom.variants]
          inherits = "ss08"

          [buildPlans.iosevka-custom.variants.design]
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

          [buildPlans.iosevka-custom.ligations]
          inherits = "dlig"

          [buildPlans.iosevka-custom.weights.regular]
          shape = 400
          menu = 400
          css = 400

          [buildPlans.iosevka-custom.widths.normal]
          shape = 500
          menu = 5
          css = "normal"

          [buildPlans.iosevka-custom.widths.extended]
          shape = 600
          menu = 7
          css = "expanded"

          [buildPlans.iosevka-custom.slopes.upright]
          angle = 0
          shape = "upright"
          menu = "upright"
          css = "normal"
        '';
      })
      # (iosevka.override {
      #   set = "custom";
      #   privateBuildPlan = ''
      #     [buildPlans.iosevka-custom]
      #     family = "Iosevka Basic"
      #     spacing = "normal"
      #     serifs = "sans"
      #     no-cv-ss = true
      #     export-glyph-names = true

      #     [buildPlans.iosevka-custom.variants.design]
      #     zero = "diamond-dotted"
      #     one = "no-base"
      #     two = "straight-neck"
      #     three = "two-arcs"
      #     four = "closed"
      #     five = "upright-flat"
      #     six = "straight-bar"
      #     seven = "straight-serifless"
      #     eight = "two-circles"
      #     nine = "straight-bar"
      #     punctuation-dot = "round"
      #     asterisk = "hex-high"
      #     paren = "large-contour"
      #     brace = "straight"
      #     guillemet = "straight"
      #     number-sign = "upright-tall"
      #     ampersand = "closed"
      #     at = "fourfold-solid-inner"
      #     dollar = "open"
      #     percent = "rings-continuous-slash"
      #     bar = "force-upright"
      #     ascii-single-quote = "straight"
      #     ascii-grave = "straight"
      #     question = "smooth"
      #     lig-ltgteq = "flat"
      #     lig-neq = "slightly-slanted"
      #     lig-equal-chain = "with-notch"
      #     lig-hyphen-chain = "without-notch"
      #     lig-double-arrow-bar = "without-notch"
      #     lig-single-arrow-bar = "without-notch"

      #     [buildPlans.iosevka-custom.ligations]
      #     inherits = "dlig"

      #     [buildPlans.iosevka-custom.weights.regular]
      #     shape = 400
      #     menu = 400
      #     css = 400

      #     [buildPlans.iosevka-custom.widths.normal]
      #     shape = 500
      #     menu = 5
      #     css = "normal"

      #     [buildPlans.iosevka-custom.widths.extended]
      #     shape = 600
      #     menu = 7
      #     css = "expanded"

      #     [buildPlans.iosevka-custom.slopes.upright]
      #     angle = 0
      #     shape = "upright"
      #     menu = "upright"
      #     css = "normal"
      #   '';
      # })
    ];
  };
}
