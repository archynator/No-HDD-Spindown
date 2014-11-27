unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, IniFiles;

type
  TForm2 = class(TForm)
    CB_StartMinimized: TCheckBox;
    CB_Startup: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    CB_MinimizeToTray: TCheckBox;
    CB_CloseToTray: TCheckBox;
    CB_IdleTime: TComboBox;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RunOnStartup(sProgTitle,sCmdLine,sKey: string; bStartup: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  tmp_StartMinimized,tmp_MinimizeToTray,tmp_CloseToTray,tmp_Startup,OK: boolean;
  tmp_Idle: byte;
  Timeout_sec: word;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
    OK:=True;
    Close;
    Form1.ShowMainForm1.Enabled:=True;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
    Close;
    Form1.ShowMainForm1.Enabled:=True;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var settings: TIniFile;
begin
    if OK then
    begin
        //Write settings
        //FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',0 and not faHidden); //unhide settings file
        settings:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini');
        settings.WriteBool('Main','StartMinimized',CB_StartMinimized.Checked);
        settings.WriteBool('Main','MinimizeToTray',CB_MinimizeToTray.Checked);
        settings.WriteBool('Main','CloseToTray',CB_CloseToTray.Checked);
        settings.WriteBool('Main','WindowsStartup',CB_Startup.Checked);
        settings.WriteInteger('Main','Timeout',CB_IdleTime.ItemIndex);
        MinimizeToTray:=CB_MinimizeToTray.Checked;
        CloseToTray:=CB_CloseToTray.Checked;
        Timeout_sec:=StrToInt(CB_IdleTime.Items.Strings[CB_IdleTime.ItemIndex])*60;
        FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',faHidden); //hide settings file

        if CB_Startup.Checked then
            RunOnStartup('NoHDDSpindown',Application.ExeName,'',True)
        else
            RunOnStartup('NoHDDSpindown',Application.ExeName,'',False);
    end
    else
    begin
        CB_StartMinimized.Checked:=tmp_StartMinimized;
        CB_MinimizeToTray.Checked:=tmp_MinimizeToTray;
        CB_CloseToTray.Checked:=tmp_CloseToTray;
        CB_Startup.Checked:=tmp_Startup;
        CB_IdleTime.ItemIndex:=tmp_Idle;
    end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
    CB_StartMinimized.Checked:=StartMinimized;
    CB_MinimizeToTray.Checked:=MinimizeToTray;
    CB_CloseToTray.Checked:=CloseToTray;
    CB_Startup.Checked:=Startup;
    CB_IdleTime.ItemIndex:=IdleTimeout;
    Timeout_sec:=StrToInt(CB_IdleTime.Items.Strings[CB_IdleTime.ItemIndex])*60;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
    tmp_StartMinimized:=CB_StartMinimized.Checked;
    tmp_MinimizeToTray:= CB_MinimizeToTray.Checked;
    tmp_CloseToTray:=CB_CloseToTray.Checked;
    tmp_Startup:=CB_Startup.Checked;
    tmp_Idle:=CB_IdleTime.ItemIndex;
    OK:=False;
end;

procedure TForm2.RunOnStartup(sProgTitle,sCmdLine,sKey: string; bStartup: boolean);
var reg: TRegIniFile;
begin
    //sKey := 'Once' if you wish it to only run on the next time you startup.
    if bStartup = false then  //If value passed is false, then value deleted from Registry.
    begin
        try
            reg:= TRegIniFile.Create('');
            reg.RootKey := HKEY_CURRENT_USER;
            reg.DeleteKey('Software\Microsoft\Windows\CurrentVersion\Run'+
            sKey+#0, sProgTitle);
            reg.Free;
        except  //Using Try Except so that if value can not be placed in registry, it
                //will not give and error.
        end;
    end
    else
    try
        reg:= TRegIniFile.Create('');
        reg.RootKey:= HKEY_CURRENT_USER;
        reg.WriteString('Software\Microsoft\Windows\CurrentVersion\Run'+
        sKey+#0, sProgTitle, sCmdLine);
        reg.Free;
    except

    end;
end;

end.
