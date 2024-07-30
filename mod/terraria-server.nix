{ ... }: {
  services.terraria = {
    enable = true;
    password = "combine";
    openFirewall = true;
    messageOfTheDay = "don't cause harm";
    autoCreatedWorldSize = "large";
  };
}
