#
# This file is a part of the Sharemind framework.
# Copyright (C) Cybernetica AS
#
# All rights are reserved. Reproduction in whole or part is prohibited
# without the written consent of the copyright owner. The usage of this
# code is subject to the appropriate license agreement.
#
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(qtcreator-plugin-sharemind-mpc VERSION 0.1.1)

INCLUDE("${CMAKE_CURRENT_SOURCE_DIR}/config.local" OPTIONAL)
INCLUDE("${CMAKE_CURRENT_BINARY_DIR}/config.local" OPTIONAL)

FIND_PACKAGE(SharemindCMakeHelpers 1.6 REQUIRED)

SET(SRCDIR "${CMAKE_CURRENT_SOURCE_DIR}/src")

INSTALL(
    FILES ${SRCDIR}/generic-highlighter/sc.xml
    DESTINATION "share/qtcreator/generic-highlighter/"
    COMPONENT "plugin"
    )
INSTALL(
    FILES ${SRCDIR}/mime/secrec.xml
    DESTINATION "share/mime/packages/"
    COMPONENT "plugin"
    )
FILE(GLOB QTCREATOR_EXTERNALTOOLS "${SRCDIR}/externaltools/*.xml")
INSTALL(
    FILES ${QTCREATOR_EXTERNALTOOLS}
    DESTINATION "share/qtcreator/externaltools/"
    COMPONENT "plugin"
    )
FILE(GLOB QTCREATOR_SCRIPTS "${SRCDIR}/scripts/*.sh")
INSTALL(PROGRAMS ${QTCREATOR_SCRIPTS}
    DESTINATION "bin"
    COMPONENT "plugin"
    )

# Packaging:
SharemindSetupPackaging()
SharemindAddComponentPackage("plugin"
    NAME "qtcreator-plugin-sharemind-mpc"
    DESCRIPTION "Sharemind SDK development plugin and helper scripts for QtCreator"
    DEB_SECTION "devel"
    DEB_RECOMMENDS
        "qtcreator"
)
SharemindPackagingFinalize()
