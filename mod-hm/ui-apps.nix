{ config, pkgs, lib, ... }: {
	imports = [
		./firefox.nix
		./vscode.nix
		./themes.nix
	];

	options.flame.ui.cursorSize = lib.mkOption {
		default = 24;
	};

	config = {
		home.packages = with pkgs; [
			nerdfonts
			obsidian
			vlc
			libreoffice
			hunspellDicts.en_US
			godot_4
			bambu-studio
			prismlauncher
			gnome.file-roller
			# fm # really good looking file manager, gonna wait until it's a bit better on the back end
			pcmanfm
			bottles
			geeqie
		];

		programs  = {
			kitty = {
				enable = true;
				theme = config.colorScheme.name;
			};

			vesktop = {
				enable = true;
				settings = {
					discordBranch = "stable";
					arRPC = "on";
					hardwareAcceleration = false;
					disableMinSize = true;
					splashTheming = true;
				};

				vencord = {
					theme = ''
						/**
						* @name Rosé Pine
						* @author blueb/Papa Quill
						* @authorId 403390454273409028
						* @version 3.0.9
						* @description All natural pine, faux fur and a bit of soho vibes for the classy minimalist.
						* @source https://github.com/rose-pine/discord
						* @updateUrl https://github.com/rose-pine/discord/blob/rose-pine.theme.css
						*/

						@import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@300..700&display=swap');
						:root {
						--Chat-Font-Used: 'Fira Code', monospace ;
						--Chat-Font-Size: 14px;

								--font-primary: var(--Chat-Font-Used);
								--font-display: var(--Chat-Font-Used);
								--font-code: var(--Chat-Font-Used);
						}

						.theme-dark {
								--input-background: #1f1d2e;
								--bg-overlay-chat: #26233a;
								--home-background: #26233a;
								--modal-footer-background: #26233a;
								--primary-600: #26233a;
								--bg-mod-faint: #6e6af622;
								--card-secondary-bg: #00000060;
								--background-message-highlight: #6e6af633;
								--background-message-highlight-hover: #6e6af622;
								--background-mentioned: #6e6af633;
								--background-mentioned-hover: #6e6af622;
								--info-warning-foreground: #6e6af6;
								--background-primary: #26233a;
								--background-secondary: #1f1d2e;
								--background-secondary-alt: #26233a;
								--channeltextarea-background: #2c2842;
								--background-tertiary: #191724;
								--background-accent: #0000003a;
								--text-normal: #dad7fd;
								--text-spotify: #9ccfd8;
								--text-muted: #4f4c58;
								--text-link: #31748f;
								--background-floating: #1f1d2e;
								--header-primary: #e0def4;
								--header-secondary: #9ccfd8;
								--interactive-normal: #e0def4;
								--interactive-hover: #c4a7e7;
								--interactive-active: #e0def4;
								--ping: #eb6f92;
								--background-modifier-selected: #26233ab4;
								--scrollbar-thin-thumb: #191724;
								--scrollbar-thin-track: transparent;
								--scrollbar-auto-thumb: #191724;
								--scrollbar-auto-track: transparent;
						}

						.theme-light {
								--background-primary: #faf4ed;
								--background-secondary: #fffaf3;
								--background-secondary-alt: #f2e9de;
								--channeltextarea-background: #f2e9de;
								--background-tertiary: #f2e9de;
								--background-accent: #d7827e;
								--text-normal: #575279;
								--text-spotify: #575279;
								--text-muted: #6e6a86;
								--text-link: #286983;
								--background-floating: #f2e9de;
								--header-primary: #575279;
								--header-secondary: #575279;
								--header-spotify: #56949f;
								--interactive-normal: #575279;
								--interactive-hover: #6e6a86;
								--interactive-active: #575279;
						}

						.mainCard__0ec2c {
								background-color: var(--background-secondary) !important;
						}

						.body-2wLx-E,
						.headerTop-3GPUSF,
						.bodyInnerWrapper-2bQs1k,
						.footer-3naVBw,
						.panels-3wFtMD {
								background-color: var(--background-tertiary) !important;
						}

						.peopleColumn-1wMU14,
						.panels-j1Uci_,
						.peopleColumn-29fq28,
						.peopleList-2VBrVI,
						.content-2hZxGK,
						.header-1zd7se,
						.root-g14mjS .small-23Atuv .fullscreenOnMobile-ixj0e3 {
								background-color: var(--background-secondary) !important;
						}

						.textArea-12jD-V,
						.lookBlank-3eh9lL,
						.threadSidebar-1o3BTy,
						.scrollableContainer-2NUZem,
						.perksModalContentWrapper-3RHugb,
						.theme-dark .footer-31IekZ,
						.theme-light .footer-31IekZ {
								background-color: var(--background-tertiary) !important;
						}

						.numberBadge-2s8kKX,
						.base-PmTxvP,
						.baseShapeRound-1Mm1YW,
						.bar-30k2ka,
						.unreadMentionsBar-1Bu1dC,
						.mention-1f5kbO,
						.active-1SSsBb,
						.disableButton-220a9y {
								background-color: var(--ping) !important;
						}

						.lookOutlined-3sRXeN.colorRed-1TFJan {
								color: var(--ping) !important;
						}

						.header-3OsQeK,
						.container-ZMc96U {
								box-shadow: none !important;
								border: none !important;
						}

						.content-1gYQeQ,
						.layout-1qmrhw,
						.inputDefault-3FGxgL,
						.input-2g-os5,
						.input-2z42oC,
						.role-2TIOKu,
						.searchBar-jGtisZ {
								border-radius: 6px !important;
						}

						.layout-1qmrhw:hover,
						.content-1gYQeQ:hover {
								background-color: var(--background-modifier-selected) !important;
						}
					'';
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
		};

		xdg.desktopEntries = {
      shutdown = {
        name = "Shutdown now";
        exec = "shutdown now";
        comment = "Shutdown computer immediately";
        categories = [ "Utility" ];
      };
      reboot = {
        name = "Reboot";
        exec = "reboot";
        categories = [ "Utility" ];
      };
    };
	};
}
