codeunit 50001 "SDH Odata API"
{
    procedure GetWelcomeMessage(): text
    begin
        exit('Welcome to Unbound ODATA API');
    end;

    procedure GetFirstItemDescription(): Text
    var
        Item: Record Item;
    begin
        if Item.FindFirst() then
            exit(Item.Description);
    end;

    procedure GetItemLastModified(ItemNo: Code[20]): DateTime
    var
        Item: Record "Item";
    begin
        If Item.Get(ItemNo) then
            exit(Item.SystemModifiedAt);
    end;

    procedure GetItemInventory(ItemNo: Code[20]): Decimal
    var
        Item: Record Item;
    begin
        If Item.Get(ItemNo) then begin
            Item.CalcFields(Inventory);
            exit(Item.Inventory);
        end else
            exit(0);
    end;

    procedure GetItemJson(ItemNo: Code[20]) ReturnText: Text
    var
        Item: Record "Item";
        Json: JsonObject;
    begin
        if Item.Get(ItemNo) then begin
            Json.Add('No.', Item."No.");
            Json.Add('Description', Item.Description);
        end;
        Json.WriteTo(ReturnText);
    end;

    // procedure GetItemList(): List of [Code[20]]
    // var
    //     Item: Record "Item";
    //     ItemList: List of [Code[20]];
    // begin
    //     if Item.FindSet() then
    //         repeat
    //             ItemList.Add(Item."No.");
    //         until Item.Next() = 0;
    //     exit(ItemList);
    // end;

    // procedure GetItemJson(ItemNo: Code[20]) Json: JsonObject
    // var
    //     Item: Record "Item";
    // begin
    //     if Item.Get(ItemNo) then begin
    //         Json.Add('No.', Item."No.");
    //         Json.Add('Description', Item.Description);
    //     end;
    // end;
}