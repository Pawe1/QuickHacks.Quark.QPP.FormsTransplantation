unit FormCleaner;

interface

uses
  System.Classes;

procedure Clean(const AStream: TStream);

implementation

uses
  Xml.XMLDoc, Xml.XMLIntf;

procedure DeleteChildNode(const ANode: IXMLNode; const AName: string);
var
  Index: integer;
begin
  Assert(Assigned(ANode));
  Index := ANode.ChildNodes.IndexOf(AName);
  if Index >= 0 then
    ANode.ChildNodes.Delete(Index);
end;

procedure DeleteAttribute(const ANode: IXMLNode; const AName: string);
var
  Index: integer;
begin
  Assert(Assigned(ANode));
  Index := ANode.AttributeNodes.IndexOf(AName);
  if Index >= 0 then
    ANode.AttributeNodes.Delete(Index);
end;

procedure Clean(const AStream: TStream);
var
  XMLDocument: IXMLDocument;   // TXMLDocument uses ARC

  LC1, LC2: Integer;

  RootNode: IXMLNode;
  FormInfoNode: IXMLNode;

  AttributeListNode: IXMLNode;
  FormAttributeNode: IXMLNode;
begin
  XMLDocument := TXMLDocument.Create(nil);

  XMLDocument.LoadFromStream(AStream);
  XMLDocument.Active;
  Assert(not XMLDocument.IsEmptyDoc);

  RootNode := XMLDocument.DocumentElement;   // formInfoList
  for LC1 := 0 to RootNode.ChildNodes.Count - 1 do
  begin
    FormInfoNode := RootNode.ChildNodes.Nodes[LC1];

    DeleteChildNode(FormInfoNode, 'contentTypeId');
    DeleteChildNode(FormInfoNode, 'workflowId');
    DeleteAttribute(FormInfoNode, 'id');

    AttributeListNode := FormInfoNode.ChildNodes.FindNode('formAttributeList');
    for LC2 := 0 to AttributeListNode.ChildNodes.Count - 1 do
    begin
      FormAttributeNode := AttributeListNode.ChildNodes.Nodes[LC2];
      DeleteAttribute(FormAttributeNode, 'id');
    end;
  end;

  AStream.Size := 0;
  XMLDocument.SaveToStream(AStream);
end;

end.
