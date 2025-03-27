-- アプリケーションファイルのあるパスを取得
set appPath to (path to me as string)
display dialog "appPath: " & appPath buttons {"OK"} default button "OK" -- デバッグ用

-- 親フォルダのパスを取得
try
    set appFolder to (container of (appPath as alias))
    set appFolderPath to POSIX path of appFolder
    display dialog "appFolderPath: " & appFolderPath buttons {"OK"} default button "OK" -- デバッグ用
on error errMsg
    display dialog "Failed to get container: " & errMsg buttons {"OK"} default button "OK"
    return -- エラー時に終了
end try

-- dataフォルダのパスを構築
set dataFolderPath to appFolderPath & "data/notify/"

-- data/notify/ フォルダが存在するか確認し、なければ作成
tell application "System Events"
    if not (exists folder dataFolderPath) then
        make new folder at appFolderPath with properties {name: "data"}
        make new folder at (appFolderPath & "data/") with properties {name: "notify"}
    end if
end tell

-- 出力するファイルパスを指定
set filePath to dataFolderPath & "_mac.txt"

-- ファイルを新規作成して書き込み開始
try
    set textFile to open for access (filePath as POSIX file) with write permission
    set eof of textFile to 0 -- 内容をクリア
    write "データが更新されました。" to textFile
    close access textFile
    display dialog "登録ありがとうございます。更新まで少々お待ちください(17時以降は明日の更新になることがあります)。 " & filePath
on error errMsg
    display dialog "エラーが発生しました: " & errMsg
end try
