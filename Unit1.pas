unit Unit1;

interface

uses
Windows, ShellAPI, Messages, SysUtils, Classes, Graphics, Controls, Forms,
Dialogs, Menus, StdCtrls, ExtCtrls, Buttons, XPMan, IniFiles, ComCtrls;

type
  TForm1 = class(TForm)  
    PopupMenu1: TPopupMenu;
    ExitApplication1: TMenuItem;
    ShowMainForm1: TMenuItem;
    N1: TMenuItem;
    Timer1: TTimer;
    ExtBtn: TBitBtn;
    EnableHDD1: TCheckBox;
    Panel1: TPanel;
    CB_interv1: TComboBox;
    Label1: TLabel;
    DriveList1: TComboBox;
    Label2: TLabel;
    RB_sec1: TRadioButton;
    RB_min1: TRadioButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    HDD1Time: TLabel;
    EnableHDD2: TCheckBox;
    CB_idle1: TCheckBox;
    CB_auto1: TCheckBox;
    OptBtn: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    HDD2Time: TLabel;
    CB_interv2: TComboBox;
    DriveList2: TComboBox;
    RB_sec2: TRadioButton;
    RB_min2: TRadioButton;
    Button2: TButton;
    CB_idle2: TCheckBox;
    CB_auto2: TCheckBox;
    Timer2: TTimer;
    EnableHDD3: TCheckBox;
    Panel3: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    HDD3Time: TLabel;
    CB_interv3: TComboBox;
    DriveList3: TComboBox;
    RB_sec3: TRadioButton;
    RB_min3: TRadioButton;
    Button3: TButton;
    CB_idle3: TCheckBox;
    CB_auto3: TCheckBox;
    Timer3: TTimer;
    EnableHDD4: TCheckBox;
    Panel4: TPanel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    HDD4Time: TLabel;
    CB_interv4: TComboBox;
    DriveList4: TComboBox;
    RB_sec4: TRadioButton;
    RB_min4: TRadioButton;
    Button4: TButton;
    CB_idle4: TCheckBox;
    CB_auto4: TCheckBox;
    Timer4: TTimer;
    Settings1: TMenuItem;
    TrayIcon1: TTrayIcon;
    ProgressBar1: TProgressBar;
    IdleTimer: TTimer;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure ShowMainForm1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitApplication1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure EnableHDD1Click(Sender: TObject);
    procedure EnableHDD2Click(Sender: TObject);
    procedure EnableHDD3Click(Sender: TObject);
    procedure EnableHDD4Click(Sender: TObject);
    procedure OptBtnClick(Sender: TObject);
    procedure Settings1Click(Sender: TObject);
    procedure Minimizing(Sender: TObject);
    procedure Restoring(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure CB_auto1Click(Sender: TObject);
    procedure CB_idle1Click(Sender: TObject);
    procedure DriveList1Change(Sender: TObject);
    procedure CB_interv1Change(Sender: TObject);
    procedure SaveComboBox(ident1,ident2: string; value: integer);
    procedure SaveCheckBox(ident1,ident2: string; value: boolean);
    procedure DriveList2Change(Sender: TObject);
    procedure DriveList3Change(Sender: TObject);
    procedure DriveList4Change(Sender: TObject);
    procedure CB_interv2Change(Sender: TObject);
    procedure CB_interv3Change(Sender: TObject);
    procedure CB_interv4Change(Sender: TObject);
    procedure RB_sec1Click(Sender: TObject);
    procedure RB_sec2Click(Sender: TObject);
    procedure RB_sec3Click(Sender: TObject);
    procedure RB_sec4Click(Sender: TObject);
    procedure CB_idle2Click(Sender: TObject);
    procedure CB_idle3Click(Sender: TObject);
    procedure CB_idle4Click(Sender: TObject);
    procedure CB_auto2Click(Sender: TObject);
    procedure CB_auto3Click(Sender: TObject);
    procedure CB_auto4Click(Sender: TObject);
    procedure IdleTimerTimer(Sender: TObject);
    procedure AdjustProgressBar(tmp_PB: TProgressBar; tmp_Timer: TTimer; IsIdle: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var  
  Form1: TForm1;
  H_File: THandle;
  current_time1, time1, current_time2, time2, current_time3, time3,
  current_time4, time4, IdleTimeout: word;
  FormTop, FormLeft: smallint;
  StartMinimized, MinimizeToTray, CloseToTray, Startup: boolean;
  FormShown: boolean;

implementation

uses Unit2;

{$R *.DFM}

function AddLeadingZeroes(const aNumber, Length : integer) : string;
begin
   result := SysUtils.Format('%.*d', [Length, aNumber]) ;
end;

function SecondsIdle: DWord;
var
   liInfo: TLastInputInfo;
begin
   liInfo.cbSize := SizeOf(TLastInputInfo) ;
   GetLastInputInfo(liInfo) ;
   Result := (GetTickCount - liInfo.dwTime) DIV 1000;
end;

procedure TForm1.FormCreate(Sender: TObject);
var param: string;
    settings: TIniFile;
    tmp_file: TMemo;
const values=',Enabled=,Drive=,WriteInterval=,Unit=,Idle=,Autostart=';
begin
    Form1.ClientHeight:=Panel1.Top+Panel1.Height-1;
    Form1.ClientWidth:=OptBtn.Left+OptBtn.Width+6;

    Application.Title:='No HDD Spindown';

    Application.OnMinimize:=Minimizing;
    Application.OnRestore:=Restoring;

    //Check if settings file exists. Create a nice template if it doesn't
    if FileExists(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini')=False then
    begin
        tmp_file:=TMemo.Create(Self);
        tmp_file.Parent:=Form1;
        tmp_file.Visible:=False;
        tmp_file.Lines.CommaText:='[Main],Top=,Left=,StartMinimized=,MinimizeToTray=,'+
        'CloseToTray=,WindowsStartup=,Timeout=,,'+
        '[HDD1]'+values+',,[HDD2]'+values+',,[HDD3]'+values+',,[HDD4]'+values;
        tmp_file.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini');
        FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',faHidden); //hide settings file
        tmp_file.Destroy;
    end;

    //Read settings
    //FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',0 and not faHidden); //unhide settings file
    settings:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini');
    FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',faHidden); //hide settings file
    //read main settings
    FormTop:=settings.ReadInteger('Main','Top',round((Screen.Height-Height)/2));
    FormLeft:=settings.ReadInteger('Main','Left',round((Screen.Width-Width)/2));
    Top:=FormTop;
    Left:=FormLeft;
    StartMinimized:=settings.ReadBool('Main','StartMinimized',False);
    MinimizeToTray:=settings.ReadBool('Main','MinimizeToTray',False);
    CloseToTray:=settings.ReadBool('Main','CloseToTray',False);;
    Startup:=settings.ReadBool('Main','WindowsStartup',False);
    IdleTimeout:=settings.ReadInteger('Main','Timeout',9);
    //read hdd1 settings
    EnableHDD1.Checked:=settings.ReadBool('HDD1','Enabled',False);
    DriveList1.ItemIndex:=settings.ReadInteger('HDD1','Drive',-1);
    CB_interv1.ItemIndex:=settings.ReadInteger('HDD1','WriteInterval',4);
    RB_sec1.Checked:=settings.ReadBool('HDD1','Unit',False);
    CB_idle1.Checked:=settings.ReadBool('HDD1','Idle',False);
    CB_auto1.Checked:=settings.ReadBool('HDD1','Autostart',False);
    if CB_auto1.Checked then
        Button1.Click;
    //read hdd2 settings
    if EnableHDD1.Checked then
        EnableHDD2.Checked:=settings.ReadBool('HDD2','Enabled',False);
    DriveList2.ItemIndex:=settings.ReadInteger('HDD2','Drive',-1);
    CB_interv2.ItemIndex:=settings.ReadInteger('HDD2','WriteInterval',4);
    RB_sec2.Checked:=settings.ReadBool('HDD2','Unit',False);
    CB_idle2.Checked:=settings.ReadBool('HDD2','Idle',False);
    CB_auto2.Checked:=settings.ReadBool('HDD2','Autostart',False);
    if CB_auto2.Checked then
        Button2.Click;
    //read hdd3 settings
    if EnableHDD2.Checked then
        EnableHDD3.Checked:=settings.ReadBool('HDD3','Enabled',False);
    DriveList3.ItemIndex:=settings.ReadInteger('HDD3','Drive',-1);
    CB_interv3.ItemIndex:=settings.ReadInteger('HDD3','WriteInterval',4);
    RB_sec3.Checked:=settings.ReadBool('HDD3','Unit',False);
    CB_idle3.Checked:=settings.ReadBool('HDD3','Idle',False);
    CB_auto3.Checked:=settings.ReadBool('HDD3','Autostart',False);
    if CB_auto3.Checked then
        Button3.Click;
    //read hdd4 settings
    if EnableHDD3.Checked then
        EnableHDD4.Checked:=settings.ReadBool('HDD4','Enabled',False);
    DriveList4.ItemIndex:=settings.ReadInteger('HDD4','Drive',-1);
    CB_interv4.ItemIndex:=settings.ReadInteger('HDD4','WriteInterval',4);
    RB_sec4.Checked:=settings.ReadBool('HDD4','Unit',False);
    CB_idle4.Checked:=settings.ReadBool('HDD4','Idle',False);
    CB_auto4.Checked:=settings.ReadBool('HDD4','Autostart',False);
    if CB_auto4.Checked then
        Button4.Click;

    if StartMinimized then
    begin
        if MinimizeToTray then
        begin
            TrayIcon1.Visible:=True;
            FormShown:=False;
            Application.ShowMainForm:=False;
        end
        else
        begin
            FormShown:=True;
            Application.Minimize;
            Form1.Show;
            Form1.Top:=FormTop;
            Form1.Left:=FormLeft;
        end;
    end
    else
    begin
        Form1.Show;
        FormShown:=True;
        Form1.Top:=FormTop;
        Form1.Left:=FormLeft
    end;
end;

procedure TForm1.IdleTimerTimer(Sender: TObject);
var settings: TIniFile;
begin
    if (CB_idle1.Checked) and (Button1.Caption='Stop')then
        if SecondsIdle<Timeout_sec then
            AdjustProgressBar(ProgressBar1, Timer1, False)
        else
            AdjustProgressBar(ProgressBar1, Timer1, True)
    else
        ProgressBar1.Position:=0;

    if (CB_idle2.Checked) and (Button2.Caption='Stop')then
        if SecondsIdle<Timeout_sec then
            AdjustProgressBar(ProgressBar2, Timer2, False)
        else
            AdjustProgressBar(ProgressBar2, Timer2, True)
    else
        ProgressBar2.Position:=0;

    if (CB_idle3.Checked) and (Button3.Caption='Stop')then
        if SecondsIdle<Timeout_sec then
            AdjustProgressBar(ProgressBar3, Timer3, False)
        else
            AdjustProgressBar(ProgressBar3, Timer3, True)
    else
        ProgressBar3.Position:=0;

    if (CB_idle4.Checked) and (Button4.Caption='Stop')then
        if SecondsIdle<Timeout_sec then
            AdjustProgressBar(ProgressBar4, Timer4, False)
        else
            AdjustProgressBar(ProgressBar4, Timer4, True)
    else
        ProgressBar4.Position:=0;

    //additional function as coordinate saver
    if ((FormTop<>Form1.Top) or (FormLeft<>Form1.Left)) and (FormShown) then
    begin
        settings:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini');
        FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',faHidden); //hide settings file
        settings.WriteInteger('Main','Top',Form1.Top);
        settings.WriteInteger('Main','Left',Form1.Left);
    end;
end;

procedure TForm1.Minimizing;
begin
    if MinimizeToTray then
    begin
        Form1.Hide;
        TrayIcon1.Visible:=True;
    end;
end;

procedure TForm1.AdjustProgressBar(tmp_PB: TProgressBar; tmp_Timer: TTimer; IsIdle: Boolean);
begin
    if IsIdle then
    begin
        tmp_PB.Position:=tmp_PB.Max;
        tmp_PB.State:=pbsError;
        tmp_Timer.Enabled:=False;
    end
    else
    begin
        tmp_PB.Position:=round(SecondsIdle*100/Timeout_sec);
        tmp_PB.State:=pbsNormal;
        tmp_Timer.Enabled:=True;
    end;
end;

procedure TForm1.SaveCheckBox(ident1, ident2: string; value: boolean);
var settings: TIniFile;
begin
    settings:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini');
    settings.WriteBool(ident1,ident2,value);
    FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',faHidden); //hide settings file
end;

procedure TForm1.SaveComboBox(ident1, ident2: string; value: integer);
var settings: TIniFile;
begin
    settings:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini');
    settings.WriteInteger(ident1,ident2,value);
    FileSetAttr(ExtractFilePath(Application.ExeName)+'No HDD Spindown.ini',faHidden); //hide settings file
end;

procedure TForm1.Settings1Click(Sender: TObject);
begin
    ShowMainForm1.Enabled:=False;
    Form2.Show;
end;

procedure TForm1.ShowMainForm1Click(Sender: TObject);
begin
    Form1.Show;
    WindowState:=wsNormal;
    Application.BringToFront();
    TrayIcon1.Visible:=False;
    Application.Restore;
    if FormShown=False then
    begin
        Form1.Top:=FormTop;
        Form1.Left:=FormLeft;
        FormShown:=True;
    end;
//    SetForeGroundWindow(Handle);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var str: PChar;
    written: cardinal;
    mm, ss: byte;
begin
    if current_time1=time1 then
    begin
        str:='No HDD Spindown';
        H_File:=CreateFileW(PChar(DriveList1.Text+':\No HDD Spindown.txt'),GENERIC_WRITE,FILE_SHARE_READ,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
        if (GetLastError() = INVALID_HANDLE_VALUE) then
        begin
            ShowMessage('Couldn''t create the file on drive '+DriveList1.Text);
            Timer1.Enabled:=False;
            Button1.Caption:='Start';
            Exit;
        end;
        WriteFile(H_File,str,Length(str),written,nil);
        FileClose(H_File);
        current_time1:=0;
    end;
    Inc(current_time1);
    mm:=(time1-current_time1) div 60;
    ss:=(time1-current_time1) mod 60;
    HDD1Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var str: PChar;
    written: cardinal;
    mm, ss: byte;
begin
    if current_time2=time2 then
    begin
        str:='No HDD Spindown';
        H_File:=CreateFileW(PChar(DriveList2.Text+':\No HDD Spindown.txt'),GENERIC_WRITE,FILE_SHARE_READ,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
        if (GetLastError() = INVALID_HANDLE_VALUE) then
        begin
            ShowMessage('Couldn''t create the file on drive '+DriveList2.Text);
            Timer2.Enabled:=False;
            Button2.Caption:='Start';
            Exit;
        end;
        WriteFile(H_File,str,Length(str),written,nil);
        FileClose(H_File);
        current_time2:=0;
    end;
    Inc(current_time2);
    mm:=(time2-current_time2) div 60;
    ss:=(time2-current_time2) mod 60;
    HDD2Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var str: PChar;
    written: cardinal;
    mm, ss: byte;
begin
    if current_time3=time3 then
    begin
        str:='No HDD Spindown';
        H_File:=CreateFileW(PChar(DriveList3.Text+':\No HDD Spindown.txt'),GENERIC_WRITE,FILE_SHARE_READ,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
        if (GetLastError() = INVALID_HANDLE_VALUE) then
        begin
            ShowMessage('Couldn''t create the file on drive '+DriveList3.Text);
            Timer3.Enabled:=False;
            Button3.Caption:='Start';
            Exit;
        end;
        WriteFile(H_File,str,Length(str),written,nil);
        FileClose(H_File);
        current_time3:=0;
    end;
    Inc(current_time3);
    mm:=(time3-current_time3) div 60;
    ss:=(time3-current_time3) mod 60;
    HDD3Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
end;

procedure TForm1.Timer4Timer(Sender: TObject);
var str: PChar;
    written: cardinal;
    mm, ss: byte;
begin
    if current_time4=time4 then
    begin
        str:='No HDD Spindown';
        H_File:=CreateFileW(PChar(DriveList4.Text+':\No HDD Spindown.txt'),GENERIC_WRITE,FILE_SHARE_READ,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
        if (GetLastError() = INVALID_HANDLE_VALUE) then
        begin
            ShowMessage('Couldn''t create the file on drive '+DriveList4.Text);
            Timer4.Enabled:=False;
            Button4.Caption:='Start';
            Exit;
        end;
        WriteFile(H_File,str,Length(str),written,nil);
        FileClose(H_File);
        current_time4:=0;
    end;
    Inc(current_time4);
    mm:=(time4-current_time4) div 60;
    ss:=(time4-current_time4) mod 60;
    HDD4Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//when the user clicks the close button in the corner,
//only hide the form, not exit the app.
    if CloseToTray then
    begin
        Action := caNone;
        Form1.Hide;
        TrayIcon1.Visible:=True;
        Exit;
    end;

    Application.ProcessMessages;
    Application.Terminate;
end;

procedure TForm1.EnableHDD1Click(Sender: TObject);
var i: byte;
begin
    if EnableHDD1.Checked then
    begin
        for i:=0 to Panel1.ControlCount-1 do
            Panel1.Controls[i].Enabled:= True;
        Form1.ClientHeight:=EnableHDD2.Top+EnableHDD2.Height+6;
    end
    else
    begin
        for i:=0 to Panel1.ControlCount-1 do
            Panel1.Controls[i].Enabled:= False;
        Form1.ClientHeight:=Panel1.Top+Panel1.Height-1;
        if Timer1.Enabled then
            Button1.Click;
    end;

    //Write settings
    SaveCheckBox('HDD1','Enabled',EnableHDD1.Checked);
end;

procedure TForm1.EnableHDD2Click(Sender: TObject);
begin
    Panel2.Visible:= not Panel2.Visible;
    if EnableHDD2.Checked then
    begin
        EnableHDD1.Enabled:=False;
        Form1.ClientHeight:=EnableHDD3.Top+EnableHDD3.Height+6;
    end
    else
    begin
        EnableHDD1.Enabled:=True;
        Form1.ClientHeight:=EnableHDD2.Top+EnableHDD2.Height+6;
        if Timer2.Enabled then
            Button2.Click;
    end;

    //Write settings
    SaveCheckBox('HDD2','Enabled',EnableHDD2.Checked);
end;

procedure TForm1.EnableHDD3Click(Sender: TObject);
begin
    Panel3.Visible:= not Panel3.Visible;
    if EnableHDD3.Checked then
    begin
        EnableHDD2.Enabled:=False;
        Form1.ClientHeight:=EnableHDD4.Top+EnableHDD4.Height+6;
    end
    else
    begin
        EnableHDD2.Enabled:=True;
        Form1.ClientHeight:=EnableHDD3.Top+EnableHDD3.Height+6;
        if Timer3.Enabled then
            Button3.Click;
    end;

    //Write settings
    SaveCheckBox('HDD3','Enabled',EnableHDD3.Checked);
end;

procedure TForm1.EnableHDD4Click(Sender: TObject);
begin
    Panel4.Visible:= not Panel4.Visible;
    if EnableHDD4.Checked then
    begin
        EnableHDD3.Enabled:=False;
        Form1.ClientHeight:=Panel4.Top+Panel4.Height-1;
    end
    else
    begin
        EnableHDD3.Enabled:=True;
        Form1.ClientHeight:=EnableHDD4.Top+EnableHDD4.Height+6;
        if Timer4.Enabled then
            Button4.Click;
    end;

    //Write settings
    SaveCheckBox('HDD4','Enabled',EnableHDD4.Checked);
end;

procedure TForm1.ExitApplication1Click(Sender: TObject);
begin
    Application.ProcessMessages;
    Application.Terminate;
end;

procedure TForm1.OptBtnClick(Sender: TObject);
begin
    Form2.ShowModal;
end;

procedure TForm1.RB_sec1Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD1','Unit',RB_sec1.Checked);
end;

procedure TForm1.RB_sec2Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD2','Unit',RB_sec2.Checked);
end;

procedure TForm1.RB_sec3Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD3','Unit',RB_sec3.Checked);
end;

procedure TForm1.RB_sec4Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD4','Unit',RB_sec4.Checked);
end;

procedure TForm1.Restoring(Sender: TObject);
begin
    Form1.WindowState:=wsNormal;
end;

procedure TForm1.Button1Click(Sender: TObject);
var mm, ss: byte;
begin
    if DirectoryExists(Drivelist1.Text+':\') then

    if Timer1.Enabled then
    begin
        Timer1.Enabled:=False;
        HDD1Time.Caption:='HDD access in: --:--';
        Button1.Caption:='Start';
    end
    else
    begin
        if RB_sec1.Checked then
            time1:=StrToInt(CB_interv1.Text)
        else
            time1:=StrToInt(CB_interv1.Text)*60;
        current_time1:=1;
        Timer1.Enabled:=True;

        mm:=(time1-current_time1) div 60;
        ss:=(time1-current_time1) mod 60;
        HDD1Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
        Button1.Caption:='Stop';
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var mm, ss: byte;
begin
    if DirectoryExists(Drivelist2.Text+':\') then

    if Timer2.Enabled then
    begin
        Timer2.Enabled:=False;
        HDD2Time.Caption:='HDD access in: --:--';
        Button2.Caption:='Start';
    end
    else
    begin
        if RB_sec2.Checked then
            time2:=StrToInt(CB_interv2.Text)
        else
            time2:=StrToInt(CB_interv2.Text)*60;
        current_time2:=1;
        Timer2.Enabled:=True;

        mm:=(time2-current_time2) div 60;
        ss:=(time2-current_time2) mod 60;
        HDD2Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
        Button2.Caption:='Stop';
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var mm, ss: byte;
begin
    if DirectoryExists(Drivelist3.Text+':\') then

    if Timer3.Enabled then
    begin
        Timer3.Enabled:=False;
        HDD3Time.Caption:='HDD access in: --:--';
        Button3.Caption:='Start';
    end
    else
    begin
        if RB_sec3.Checked then
            time3:=StrToInt(CB_interv3.Text)
        else
            time3:=StrToInt(CB_interv3.Text)*60;
        current_time3:=1;
        Timer3.Enabled:=True;

        mm:=(time3-current_time3) div 60;
        ss:=(time3-current_time3) mod 60;
        HDD3Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
        Button3.Caption:='Stop';
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var mm, ss: byte;
begin
    if DirectoryExists(Drivelist4.Text+':\') then

    if Timer4.Enabled then
    begin
        Timer4.Enabled:=False;
        HDD4Time.Caption:='HDD access in: --:--';
        Button4.Caption:='Start';
    end
    else
    begin
        if RB_sec4.Checked then
            time4:=StrToInt(CB_interv4.Text)
        else
            time4:=StrToInt(CB_interv4.Text)*60;
        current_time4:=1;
        Timer4.Enabled:=True;

        mm:=(time4-current_time4) div 60;
        ss:=(time4-current_time4) mod 60;
        HDD4Time.Caption:='HDD access in: '+AddLeadingZeroes(mm,2)+':'+AddLeadingZeroes(ss,2);
        Button4.Caption:='Stop';
    end;
end;

procedure TForm1.CB_auto1Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD1','Autostart',CB_auto1.Checked);
end;

procedure TForm1.CB_auto2Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD2','Autostart',CB_auto2.Checked);
end;

procedure TForm1.CB_auto3Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD3','Autostart',CB_auto3.Checked);
end;

procedure TForm1.CB_auto4Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD4','Autostart',CB_auto4.Checked);
end;

procedure TForm1.CB_idle1Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD1','Idle',CB_idle1.Checked);
end;

procedure TForm1.CB_idle2Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD2','Idle',CB_idle2.Checked);
end;

procedure TForm1.CB_idle3Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD3','Idle',CB_idle3.Checked);
end;

procedure TForm1.CB_idle4Click(Sender: TObject);
begin
    //Write settings
    SaveCheckBox('HDD4','Idle',CB_idle4.Checked);
end;

procedure TForm1.CB_interv1Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD1','WriteInterval',CB_interv1.ItemIndex);
end;

procedure TForm1.CB_interv2Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD2','WriteInterval',CB_interv2.ItemIndex);
end;

procedure TForm1.CB_interv3Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD3','WriteInterval',CB_interv3.ItemIndex);
end;

procedure TForm1.CB_interv4Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD4','WriteInterval',CB_interv4.ItemIndex);
end;

procedure TForm1.DriveList1Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD1','Drive',DriveList1.ItemIndex);
end;

procedure TForm1.DriveList2Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD2','Drive',DriveList2.ItemIndex);
end;

procedure TForm1.DriveList3Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD3','Drive',DriveList3.ItemIndex);
end;

procedure TForm1.DriveList4Change(Sender: TObject);
begin
    //Write settings
    SaveComboBox('HDD4','Drive',DriveList4.ItemIndex);
end;

end.
