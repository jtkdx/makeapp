-- アプリケーションファイルのあるフォルダのパスを取得
set appPath to (path to me as string)
set appFolderPath to (POSIX path of (container of (appPath as alias)))

-- dataフォルダのパスを取得
set dataFolderPath to appFolderPath & "data/notify/"

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
