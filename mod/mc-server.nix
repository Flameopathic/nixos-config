{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.flame.mc-server;
in
{
  options.flame.mc-server = {
    ram = lib.mkOption {
      default = "14G";
      type = lib.types.str;
      description = "RAM to allocate to Java";
    };
  };

  config = {
    services.minecraft-server = {
      enable = true;
      eula = true;
      package = pkgs.unstable.papermc;
      jvmOpts = "-Xmx${cfg.ram} -Xms${cfg.ram} -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32";
      openFirewall = true;
      declarative = true;
      serverProperties = {
        enable-jmx-monitoring = false;
        gamemode = "survival";
        enable-command-block = false;
        enable-query = false;
        enforce-secure-profile = true;
        level-name = "awesomeswagworld";
        motd = "hawk tuah";
        pvp = true;
        generate-structures = true;
        max-chained-neighbor-updates = 1000000;
        difficulty = "hard";
        network-compression-threshold = 256;
        max-tick-time = 60000;
        require-resource-pack = false;
        use-native-transport = true;
        max-players = 50;
        online-mode = true;
        enable-status = true;
        allow-flight = false;
        broadcast-rcon-to-ops = true;
        view-distance = 32;
        allow-nether = true;
        server-port = 25565;
        enable-rcon = false;
        sync-chunk-writes = true;
        op-permission-level = 4;
        prevent-proxy-connections = false;
        hide-online-players = false;
        entity-broadcast-range-percentage = 100;
        simulation-distance = 10;
        player-idle-timeout = 0;
        force-gamemode = false;
        rate-limit = 0;
        hardcore = false;
        white-list = true;
        broadcast-console-to-ops = true;
        spawn-npcs = true;
        spawn-animals = true;
        log-ips = true;
        function-permission-level = 2;
        initial-enabled-packs = "vanilla";
        level-type = "minecraft:normal";
        spawn-monsters = true;
        enforce-whitelist = true;
        spawn-protection = 0;
        # max-world-size = 5000;
        # server-ip = ;
        # generator-settings = {};
        # query.port = 25565;
        # initial-disabled-packs = ;
        # resource-pack-prompt = ;
        # resource-pack = ;
        # rcon.password = ;
        # text-filtering-config = ;
        # resource-pack-sha1 = ;
        # rcon.port = 25575;
        # level-seed = ;
      };
      whitelist = {
        Flameopathic = "040ebdc7-9ca1-475d-9b3d-4fb62a29b19e";
        nox_quack = "19051a2b-ac8e-4bab-86fd-e9ab42e8de3d";
        Mercadies = "c8200af1-7fb8-48fc-83b8-1066ef221333";
        LadyIanite07 = "aefc488b-ff80-4b4f-8b73-f8241e5df6d5";
        Psycho_Blade1 = "2a4d0a8f-d55c-4c83-9db5-a06665ad1231";
        ippon_datara = "96b3cf60-32f5-4cb5-9a38-43178c59aea3";
        vio_q = "861b6592-a1aa-4b63-bb9d-aac16637f30a";
        Attticusss = "af017840-c5a7-4615-af67-edc8f52c4deb";
        Mangoey = "9f640f5a-50d7-4c57-a81d-e587a078f667";
        lopwep = "d71d994e-c94d-4e98-9d8d-6d331b56a7cf";
        TheKpOkay = "91e95661-a971-41b4-9955-3592fa5f5af4";
        bogu = "b44cb594-f0da-479d-aae2-04921feec72a";
        teemofan26 = "12b80e2a-e0ad-4601-9050-492398f31000";
        getbuilt = "de7391b2-cbb9-4be8-a596-6fb6821aac25";
        koyng8 = "e617dbac-5291-40d9-a577-114357ca754d";
        BaconMambo = "8100f226-3d1d-4aa9-b71c-94364ca71c76";
        xXMinzhenXx = "88b8e9a0-70dd-4f57-bb83-a183a73f83a0";
        HAKeller = "afaa29b2-fbff-430d-9930-d891bb0fd6ed";
        Itzatli = "df1fb96a-0d80-4c82-9a7d-160bf3536945";
        whenthejava = "17d4bd16-42d9-49d4-9917-e5f75a9e0971";
      };
    };
  };
}
