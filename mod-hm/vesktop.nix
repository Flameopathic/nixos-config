{ ... }: {
  config.programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
      arRPC = "on";
      hardwareAcceleration = false;
      disableMinSize = true;
      splashTheming = true;
    };

    vencord = {
      settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        useQuickCss = true;
        plugins = {
          BetterGifAltText.enabled = true;
          BetterGifPicker.enabled = true;
          BetterSettings.enabled = true;
          ClearURLs.enabled = true;
          CrashHandler.enabled = true;
          Dearrow.enabled = true;
          FakeNitro.enabled = true;
          FavoriteGifSearch.enabled = true;
          FixSpotifyEmbeds.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          ForceOwnerCrown.enabled = true;
          FriendsSince.enabled = true;
          GifPaste.enabled = true;
          ImageLink.enabled = true;
          ImageZoom.enabled = true;
          KeepCurrentChannel.enabled = true;
          MemberCount.enabled = true;
          MentionAvatars.enabled = true;
          MessageClickActions.enabled = true;
          MessageLinkEmbeds.enabled = true;
          MessageLogger.enabled = true;
          MoreKaomoji.enabled = true;
          MutualGroupDMs.enabled = true;
          NoF1.enabled = true;
          NSFWGateBypass.enabled = true;
          petpet.enabled = true;
          PictureInPicture.enabled = true;
          PlatformIndicators.enabled = true;
          PreviewMessage.enabled = true;
          RelationshipNotifier.enabled = true;
          ReplyTimestamp.enabled = true;
          ReverseImageSearch.enabled = true;
          ShowHiddenChannels.enabled = true;
          TypingIndicator.enabled = true;
          TypingTweaks.enabled = true;
          UnlockedAvatarZoom.enabled = true;
          UnsuppressEmbeds.enabled = true;
          UserVoiceShow.enabled = true;
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          WatchTogetherAdblock.enabled = true;
          WebScreenShareFixes.enabled = true;
        };
        cloud = {
          authenticated = true;
          url = "https://api.vencord.dev/";
          settingsSync = true;
        };
      };
    };
  };
}
