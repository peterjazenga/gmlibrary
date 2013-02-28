{
unit RegisterComp

  ES: unidad para registrar los componentes que no dependen de ningún framework
  EN: unit to register the components that no depend of any framework

=========================================================================
History:

ver 0.1.9
  ES:
    nuevo: documentación
    nuevo: se hace compatible con FireMonkey
  EN:
    new: documentation
    new: now compatible with FireMonkey
=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras,
  ampliaciones, errores y/o cualquier otro tipo de sugerencia, envíame un correo a:
  gmlib@cadetill.com

IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements,
  errors and/or any another type of suggestion, please send me a mail to:
  gmlib@cadetill.com
=========================================================================

Copyright (©) 2011, by Xavier Martinez (cadetill)

@author Xavier Martinez (cadetill)
@web  http://www.cadetill.com
}
{*------------------------------------------------------------------------------
  Unit to register the components that no depend of any framework.

  @author Xavier Martinez (cadetill)
  @version 0.1.9
-------------------------------------------------------------------------------}
{=------------------------------------------------------------------------------
  Unidad para registrar los componentes que no dependen de ningún framework.

  @author Xavier Martinez (cadetill)
  @version 0.1.9
-------------------------------------------------------------------------------}
unit RegisterComp;

{$IF CompilerVersion < 20}
{$R ..\Resources\gmlibres.res}
{$IFEND}

interface

  {*------------------------------------------------------------------------------
    The Register procedure register the components.
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    El procedimiento Register registra los componentes.
  -------------------------------------------------------------------------------}
  procedure Register;

implementation

uses
  {$IF CompilerVersion < 23}  // ES: si la versión es inferior a la XE2 - EN: if lower than XE2 version
  Classes,
  {$ELSE}                     // ES: si la verisón es la XE2 o superior - EN: if version is XE2 or higher
  System.Classes,
  {$IFEND}

  GMInfoWindow, GMGeoCode;

procedure Register;
begin
  RegisterComponents('GoogleMaps', [TGMInfoWindow, TGMGeoCode]);
end;

end.
