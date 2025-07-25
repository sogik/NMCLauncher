if(UNIX)
    find_package(PkgConfig)
    if(PkgConfig_FOUND)
        pkg_search_module(SCDOC scdoc)
        if(SCDOC_FOUND)
            pkg_get_variable(SCDOC_SCDOC scdoc scdoc)
        endif()
    endif()
endif()

set(Launcher_CommonName "NMCLauncher")
set(Launcher_DisplayName "NMC Launcher")

set(Launcher_Name "${Launcher_CommonName}" PARENT_SCOPE)
set(Launcher_DisplayName "${Launcher_DisplayName}" PARENT_SCOPE)

set(Launcher_Copyright "© 2025 sogik\\n© 2022-2025 Prism Launcher Contributors\\n© 2022-2023 PollyMC Contributors\\n© 2021-2022 PolyMC Contributors\\n© 2012-2021 MultiMC Contributors")
set(Launcher_Copyright_Mac "© 2025 sogik, © 2022-2025 Prism Launcher Contributors, © 2022-2023 PollyMC Contributors, © 2021-2022 PolyMC Contributors and © 2012-2021 MultiMC Contributors" PARENT_SCOPE)
set(Launcher_Copyright "${Launcher_Copyright}" PARENT_SCOPE)
set(Launcher_Domain "" PARENT_SCOPE)
set(Launcher_UserAgent "PrismLauncher/${Launcher_VERSION_NAME}" PARENT_SCOPE)
set(Launcher_ConfigFile "nmclauncher.cfg" PARENT_SCOPE)
set(Launcher_Git "https://github.com/sogik/NMCLauncher" PARENT_SCOPE)
set(Launcher_DesktopFileName "org.sogik.NMCLauncher.desktop" PARENT_SCOPE)
set(Launcher_SVGFileName "org.sogik.NMCLauncher.svg" PARENT_SCOPE)

set(Launcher_Desktop "program_info/org.sogik.NMCLauncher.desktop" PARENT_SCOPE)
set(Launcher_mrpack_MIMEInfo "program_info/modrinth-mrpack-mime.xml" PARENT_SCOPE)
set(Launcher_MetaInfo "program_info/org.sogik.NMCLauncher.metainfo.xml" PARENT_SCOPE)
set(Launcher_SVG "program_info/org.sogik.NMCLauncher.svg" PARENT_SCOPE)
set(Launcher_Branding_ICNS "program_info/prismlauncher.icns" PARENT_SCOPE)
set(Launcher_Branding_ICO "program_info/nmclauncher.ico")
set(Launcher_Branding_ICO "${Launcher_Branding_ICO}" PARENT_SCOPE)
set(Launcher_Branding_WindowsRC "program_info/nmclauncher.rc" PARENT_SCOPE)
set(Launcher_Branding_LogoQRC "program_info/nmclauncher.qrc" PARENT_SCOPE)

set(Launcher_Portable_File "program_info/portable.txt" PARENT_SCOPE)

configure_file(org.sogik.NMCLauncher.desktop.in org.sogik.NMCLauncher.desktop)
configure_file(org.sogik.NMCLauncher.metainfo.xml.in org.sogik.NMCLauncher.metainfo.xml)
configure_file(nmclauncher.rc.in nmclauncher.rc @ONLY)
configure_file(nmclauncher.manifest.in nmclauncher.manifest @ONLY)
configure_file(nmclauncher.ico nmclauncher.ico COPYONLY)

if(MSVC)
    set(Launcher_MSVC_Redist_NSIS_Section [=[
!ifdef haveNScurl
Section "Visual Studio Runtime"
    Var /GLOBAL vc_redist_exe
    ${If} ${IsNativeARM64}
        StrCpy $vc_redist_exe "vc_redist.arm64.exe"
    ${Else}
        StrCpy $vc_redist_exe "vc_redist.x64.exe"
    ${EndIf}
    DetailPrint 'Downloading Microsoft Visual C++ Redistributable...'
    NScurl::http GET "https://aka.ms/vs/17/release/$vc_redist_exe" "$INSTDIR\vc_redist\$vc_redist_exe" /INSIST /CANCEL /Zone.Identifier /END
    Pop $0
    ${If} $0 == "OK"
        DetailPrint "Download successful"
        ExecWait "$INSTDIR\vc_redist\$vc_redist_exe /install /passive /norestart"
    ${Else}
        DetailPrint "Download failed with error $0"
    ${EndIf}
SectionEnd
!endif
]=])
endif()

configure_file(win_install.nsi.in win_install.nsi @ONLY)

if(SCDOC_FOUND)
    set(in_scd "${CMAKE_CURRENT_SOURCE_DIR}/nmclauncher.6.scd")
    set(out_man "${CMAKE_CURRENT_BINARY_DIR}/nmclauncher.6")
    add_custom_command(
        DEPENDS "${in_scd}"
        OUTPUT "${out_man}"
        COMMAND ${SCDOC_SCDOC} < "${in_scd}" > "${out_man}"
    )
    add_custom_target(man ALL DEPENDS ${out_man})
    set(Launcher_ManPage "program_info/nmclauncher.6" PARENT_SCOPE)
endif()
