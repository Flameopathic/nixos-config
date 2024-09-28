[4mbrillo(1)[24m()                                                                                                         [4mbrillo(1)[24m()

Cameron Nemo OCTOBER 2018

[1mNAME[0m
       brillo - control the brightness of backlight and keyboard LED devices

[1mSYNOPSIS[0m
       [1mbrillo [22m[[1moperation [22m[[4mvalue[24m]] [[1m-k[22m] [[1m-q[22m|[1m-r[22m] [[1m-m[22m|[1m-c[22m] [[1m-e[22m|[1m-s [4m[22mctrl[24m] [[1m-u [4m[22musecs[24m] [[1m-v [4m[22mloglevel[24m]

[1mDESCRIPTION[0m
       [1mbrillo [22mis a tool for controlling the brightness of backlight and LED devices on Linux. Notable features include:

              • Automatic best controller detection

              • Smooth transitions and exponential (natural) adjustments

              • Ability to save and restore brightness across boots

              • Directly using [1msysfs [22mto set brightness without relying on X

              • Unprivileged access with no new setuid binaries

              • Containment with AppArmor

[1mOPTIONS[0m
       [4mOperations[0m

              • [1m-G[22m:  Get brightness value (default)

              • [1m-S [4m[22mVALUE[24m: Set brightness to value

              • [1m-A [4m[22mVALUE[24m: Increment brightness by given value

              • [1m-U [4m[22mVALUE[24m: Decrement brightness by given value

              • [1m-O[22m:  Store the current brightness

              • [1m-I[22m:  Restore cached brightness

              • [1m-L[22m:  List available devices

              • [1m-H[22m:  Show a short help output

              • [1m-V[22m:  Report the version

       [4mControllers[0m

       The  default  controller is automatically selected to maximize precision.  To select every controller available, use the
       [1m-e [22moption.  To select a specific controller, use the [1m-s [22moption.

              • [1m-a[22m:  Automatic controller selection (default)

              • [1m-e[22m:  Operate on every controller available

              • [1m-s [4m[22mCONTROLLER[24m: Manual controller selection

       The list operation ([1m-L[22m) can be used to discover available controllers.

       [4mTargets[0m

       By default, [1mbrillo [22macts on the display devices, but the [1m-k [22moption can be used to adjust keyboard backlights instead.  In
       either case, it may be necessary to specify an alternative controller.

              • [1m-l[22m:  Act on display backlight (default)

              • [1m-k[22m:  Act on keyboard backlight and LEDs

       [4mFields[0m

       By  default,  [1mbrillo  [22macts on the brightness property. With these options, the maximum brightness of a controller can be
       retrieved. In addition, it is possible to set (or retrieve) a minimum cap, which is used to prevent lowering the bright‐
       ness beyond a certain threshold. This is especially useful for devices that become pitch black when  the  brightness  is
       set to 0.

              • [1m-b[22m:  Current brightness (default)

              • [1m-m[22m:  Maximum brightness

              • [1m-c[22m:  Minimum brightness

       [4mValue[24m [4mmodes[0m

       Values may be given, or presented, in percent or raw mode.

       The default value mode is linear percentages, however the [1m-q [22moption can be used for exponential percentages. Exponential
       mode offers a more natural and gradual brightness scale.

       Raw  mode  will use the same format and range given by the device driver; this mode is most useful when a high degree of
       precision is required, such as for keyboard controllers.

              • [1m-p[22m:  Linear percentages (default)

              • [1m-q[22m:  Exponential percentages

              • [1m-r[22m:  Raw values

       [4mSmooth[24m [4madjustment[0m

       [1mbrillo [22mis capable of gradually adjusting the brightness over a specified time period. Use the [1m-u [4m[22mmicroseconds[24m option  to
       specify how long the operation should take. This flag is silently ignored when not setting the brightness.

              • [1m-u [4m[22mmicroseconds[24m:    time used to space the operation out

       [4mVerbosity[0m

       By  default,  [1mbrillo [22moutputs only warnings or more severe messages.  To enable more verbose logs on [1mstderr[22m, use the ver‐
       bosity argument: [1m-v [4m[22mloglevel[24m.  The loglevel is a value between 0 and 8 (corresponding to syslog severities).

[1mEXAMPLES[0m
       Get the current brightness in percent:

       brillo [-G]

       Increase brightness by 5 percent:

       brillo -A 5

       Specify the controller to use:

       brillo -s intel_backlight -A 5

       Set the brightness to 50% for every controller:

       brillo -e -S 50

       Retrieve or increase the brightness using an exponential scale:

       brillo -q
       brillo -q -A 5

       Decrease the brightness and smooth the operation over 1500 microseconds:

       brillo -u 150000 -U 5

       Get the raw maximum brightness value:

       brillo -rm

       Set the minimum cap for the [4macpi_video0[24m controller to a raw value of 2:

       brillo -rc -s acpi_video0 -S 2

       [4mNote[24m: subsequent attempts to set the controller's brightness to a raw value less than 2 will then be raised to this min‐
       imum threshold.

       List keyboard controllers:

       brillo -Lk

       Activate a specific controller LED:

       brillo -k -s "input15::scrolllock" -S 100

       [4mNote[24m: LEDs often only take 0 or 1 in raw value (i.e. for off/on). In these cases, you can use any non-zero value instead
       of 100.

[1mCOPYRIGHT[0m
       Copyright (C) 2018-2019 Cameron Nemo, 2014 Fredrik Haikarainen

       This is free software, see the source for copying conditions.  There is NO warranty; not  even  for  MERCHANTABILITY  or
       FITNESS FOR A PARTICULAR PURPOSE

                                                                                                                    [4mbrillo(1)[24m()
