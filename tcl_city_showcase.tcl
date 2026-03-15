#!/usr/bin/env tclsh
# TCL 城市演繹：使用城市故事展示語法

# 基礎語法：變數宣告與輸出
set cityName "語法之都"
set population 500000
puts "歡迎來到$cityName，人口約為$population 人。"

# 字串插值與格式化
set mayor "程式市長"
puts [format "%s向你致意！" $mayor]

# 數學運算
set newResidents 1500
set population [expr {$population + $newResidents}]
puts "今日有$newResidents 名新居民遷入，人口更新為 $population 人。"

# 條件判斷
if {$population > 600000} {
    puts "城市進入大都會等級。"
} elseif {$population > 400000} {
    puts "城市維持繁華中等規模。"
} else {
    puts "城市仍在成長中。"
}

# switch 用法
set district "河畔區"
switch $district {
    "河畔區" { puts "河畔區以咖啡館與藝術展聞名。" }
    "產業區" { puts "產業區的工廠機械聲此起彼落。" }
    default    { puts "這是個尚待探索的區域。" }
}

# while 迴圈：建立一排路燈
set lamp 1
while {$lamp <= 3} {
    puts "安裝第 $lamp 號路燈。"
    incr lamp
}

# for 迴圈：模擬公車班次
for {set bus 1} {$bus <= 3} {incr bus} {
    puts "公車 $bus 號準備發車。"
}

# foreach 迴圈：拜訪各區
set districts {中央商圈 城北綠地 港灣新城}
foreach name $districts {
    puts "巡查 $name 的公共建設。"
}

# list 操作
set parks [list "晨光公園" "風之廣場" "歷史樹蔭道"]
puts "公園列表: $parks"
puts "第一座公園: [lindex $parks 0]"

# dict 操作
set metro [dict create 紅線 {中央車站 西門 綠園} 藍線 {海港 市政 廣場}]
puts "捷運路線概覽:"
dict for {line stations} $metro {
    puts "  $line: $stations"
}

# proc 定義與呼叫
proc announceFestival {name date} {
    puts "城市節慶《$name》將於$date 登場！"
}
announceFestival "光影藝術節" "9 月 23 日"

# return 與局部變數
proc buildFacility {type {cost 100000}} {
    set message "已核准建造$type，預算 $cost 元。"
    return $message
}
puts [buildFacility "智慧圖書館" 250000]
puts [buildFacility "社區菜園"]

# 命名空間
namespace eval ::City {
    variable treasury 1000000
    proc spend {amount purpose} {
        variable treasury
        set treasury [expr {$treasury - $amount}]
        puts "為了$purpose 支出 $amount 元，剩餘 $treasury 元。"
    }
}

::City::spend 150000 "道路維修"

# 檔案寫入與讀取
set reportFile "city_report.txt"
set fh [open $reportFile w]
puts $fh "城市報告：人口 $population，人均幸福指數 87。"
close $fh

set fh [open $reportFile r]
set report [read $fh]
close $fh
puts "讀取檔案內容：$report"

# try/catch 錯誤處理 (Tcl 8.6 try)
try {
    set result [expr {100 / 0}]
    puts "計算結果: $result"
} trap {ARITH DIVZERO} {msg opts} {
    puts "捕捉到錯誤：$msg"
}

# 正則表達式
set street "銀河大道42號"
if {[regexp {(\d+)} $street -> number]} {
    puts "偵測到門牌號碼 $number。"
}

# coroutine 協程範例
proc trafficLight {name} {
    coroutine $name apply {{colorSeq} {
        foreach color $colorSeq {
            yield $color
        }
    }} {綠燈 黃燈 紅燈}
}

trafficLight mainLight
puts "號誌狀態：[mainLight]"
puts "號誌狀態：[mainLight]"
puts "號誌狀態：[mainLight]"

# 封包/命令擴展
set command {join {城市 的 日常} ""}
puts "命令擴展結果：[ {*}$command ]"

puts "感謝造訪語法之都，祝你旅途愉快！"
