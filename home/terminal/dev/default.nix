{
  pkgs,
  ...
} : {
    imports = [
        ./nixvim
    ];

    home.packages = with pkgs; [
        docker
        lazydocker
    ];
}
