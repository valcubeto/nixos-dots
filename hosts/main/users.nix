{ pkgs, ... }:
{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cubeto = {
        isNormalUser = true;
        # Enable ‘sudo’ for the user:
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [
            tree
        ];
        # Never set a non-posix shell as your login shell (systemd's emergency mode).
        shell = pkgs.bash;
    };
}
