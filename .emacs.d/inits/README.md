Platform |  Subplatform       | Prefix         |  Example
---------|--------------------|----------------|-----------------------------
Windows  |                    | `windows-`     |  windows-fonts.el
         |  Meadow            | `meadow-`      |  meadow-commands.el
Mac OS X |  Carbon Emacs      | `carbon-emacs-`|  carbon-emacs-applescript.el
         |  Cocoa Emacs       | `cocoa-emacs-` |  cocoa-emacs-plist.el
GNU/Linux|                    | `linux-`       |  linux-commands.el
All      |  Non-window system | `nw-`          |  nw-key.el

local rule
番号 	説明
00 	package.el等によるパッケージの導入を書く。パッケージを導入するために使う、requireしたり設定するのは別ファイルに書く。
01?19 	Emacs本体に元から備わっている機能に対する設定。
20?98 	Emacsの拡張機能に対する設定。このなかでどう割り当てるかは別途考える。
99 	キーバインドの設定。パッケージで導入した拡張機能に対してキーを割り当てることもあるので、すべてのEmacsの拡張機能が読み込まれた後に実行する。 

 	  