# Fantastic Fake Flake For Fooling Flake testsβ½
# π₯Έ Should be valid nix, but also double as a mustache template.
{
  description = "{{user}}'s flake";

  inputs = { };

  outputs = inputs@{ self, ... }: {
    lib = {

      user = /*Default is dylan (hi) for testing reasons.{{#unless user}}*/ "dylan";
      #{{else}}*/ "{{user}}";{{/unless}}
      # Change this with `mkpasswd -m sha512crypt`.
      hashed = "{{hashed}}";
      # Defaults to "/home/{{user}}/.dots"
      # You can change this manually. Just sure make you manually move the folder.
      dots = "{{dots}}";

      default_wm = "{{default_wm}}";
      networking = /*Networking π‘π‘π‘{{#unless networking}}*/ { };
      #{{else}}*/{{{networking}}};{{/unless}}

      sshd = {
        enable = /*Disabled for live images.{{#if sshd}}*/ true;
        #{{else}}*/ false;{{/if}}
        port = /*{{#unless sshd_port}}*/ 22;
        #{{else}}*/ {{sshd_port}}; #{{/unless}}
      };
      keybase = {
        enable = /*Only relevant for live images.{{#if keybase}}*/ true;
        #{{else}}*/ false;{{/if}}
        username = "{{keybase_username}}";
        paper = ''{{{keybase_paper}}}'';
      };
      git = {
        enable = /*User particular information.{{#if git}}*/ true;
        #{{else}}*/ false;{{/if}}
        name = "{{git_name}}";
        email = "{{git_email}}";
        signing = {
          enable = /*Enforce signatures.{{#if git_signing}}*/ true;
          #{{else}}*/ false;{{/if}}
          key = "{{git_signing_key}}";
        };
      };
      certificates = {
        #{{{certificates}}}
      };

      # getty can be just as pretty as lightdm imho.
      # example getty response
      #  βββββββ   β ββ β  βββ βββββββ  Linux \r (\m)
      #  β βββ β β β βββββ   β β βββ β  nixpkgs/${pkgs_rev}
      #  β βββ β βββ β β ββ ββ β βββ β  dots/${dots_rev}
      #  βββββββ βββββ βββββ β βββββββ  \d
      #  βββββ ββββββ  ββββββββ β β β
      #  βββββββββ β βββββββββββββββββ
      #  ββββ ββββββ βββ βββββ β βββββ
      #  ββββ ββββ βββ  ββββββ ββββ ββ
      #  βββ βββββ ββ  βββββ ββ βββββ
      #  βββ ββββ ββ βββββ  βββ ββββββ
      #  β βββββ β β βββ βββββββββββ β
      #  βββββββ ββ ββ  ββ βββ β β βββ
      #  β βββ β β ββ  β ββ βββββββββ
      #  β βββ β β   βββββββββ βββββββ
      #  βββββββ β β ββββ β βββ β βββ
      #
      getty = pkgs_rev: dots_rev: ''
{{getty}}
      '';
    };
  };
}
