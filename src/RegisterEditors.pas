unit RegisterEditors;

interface

  procedure Register;

implementation

uses
  UAboutFrm, GMClasses, GMEditors, GMLinkedComponents,
  Classes, DesignEditors, DesignIntf;

procedure Register;
begin
//  RegisterPropertyEditor(TypeInfo(TAboutFrm), nil, '', TAboutGMLib);

  RegisterComponentEditor(TGMBase, TGMBaseEditor);
  RegisterComponentEditor(TGMLinkedComponent, TGMLinkedComponentEditor);
end;

end.
