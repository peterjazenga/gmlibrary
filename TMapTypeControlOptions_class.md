## <font color='blue'>TMapTypeControlOptions class</font> ##

Options for the map type control


### Properties ###

  * property MapTypeIds: TMapTypeIds
    * TMapTypeIds = set of TMapTypeId;
      * !TMapTypeId = (mtHYBRID, mtROADMAP, mtSATELLITE, mtTERRAIN)  -->  <font color='green'>see <a href='https://developers.google.com/maps/documentation/javascript/reference?hl=en#MapTypeId'>this page</a> for more information</font>

> IDs of map types to show in the control.

  * property Position: TControlPosition
    * TControlPosition = (cpBOTTOM\_CENTER, cpBOTTOM\_LEFT, cpBOTTOM\_RIGHT, cpLEFT\_BOTTOM, cpLEFT\_CENTER, cpLEFT\_TOP, cpRIGHT\_BOTTOM, cpRIGHT\_CENTER, cpRIGHT\_TOP, cpTOP\_CENTER, cpTOP\_LEFT, cpTOP\_RIGHT)  -->  <font color='green'>see <a href='https://developers.google.com/maps/documentation/javascript/reference?hl=en#ControlPosition'>this page</a> for more information</font>

> Position into the map to show de control

  * property Style: TMapTypeControlStyle
    * TMapTypeControlStyle = (mtcDEFAULT, mtcDROPDOWN\_MENU, mtcHORIZONTAL\_BAR)  -->  <font color='green'>see <a href='https://developers.google.com/maps/documentation/javascript/reference?hl=en#MapTypeControlStyle'>this page</a> for more information</font>

> Menu style

  * property Show: Boolean

> Specified if the control is shown or not