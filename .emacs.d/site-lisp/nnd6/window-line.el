From ishida@sharaku.nuac.nagoya-u.ac.jp Mon Jan 24 16:09:15 1994
Newsgroups: fj.editor.emacs
From: ishida@sharaku.nuac.nagoya-u.ac.jp (Eisuke Ishida)
Subject: Re: cursor moving
In-Reply-To: ishida@sharaku.nuac.nagoya-u.ac.jp's message of Wed, 19 Jan 1994 03: 58:58 GMT
Organization: Taga&Fukuwa Lab., Dept. of Architecture, Nagoya Univ., Japan
Distribution: fj
Date: Thu, 20 Jan 1994 12:34:15 GMT


石田＠名古屋大学です。

前の記事を投稿した後、たくさんの人から「私も下さい」
という内容のメールを頂きました。
やはり需要が高いようですね。

同様の要求がある方がまだみえるかも知れないので、
ここに、九州大学の井上さんから頂いたメールの中の
引用文の部分を投稿させて頂きます。
私は、これを .emacs にコピーしてその下に

	(global-set-key "\C-p" 'previous-window-line)
	(global-set-key "\C-n" 'next-window-line)

と２行付け加えたら、思惑通り動くようになりました。
（といっても、elisp はド素人です。もっとエレガントな
やり方があるなら,どなたか教えて下さい。(_o_) ）

＃ \C-a, \C-e, \C-k 等には、対応していないみたいですね。

--------------- 引用はじめ ---------------------------------------------
From: miyata@netg.ksp.fujixerox.co.jp (Takashi Miyata)
Newsgroups: fj.editor.emacs
Subject: Re: Wordstar or VJE like key-binding
Date: 14 Jan 93 07:37:04 GMT
Reply-To: miyata@netg.ksp.fujixerox.co.jp
Distribution: fj
Organization: Fuji Xerox Co. Ltd., Tokyo, Japan
In-reply-to: ichimura@myo.inst.keio.ac.jp's message of 12 Jan 93 10:00:01 GMT

>>>>> On 12 Jan 93 10:00:01 GMT,
	ichimura@myo.inst.keio.ac.jp (Satoshi ICHIMURA) said:

> 市村＠慶應大学と申します。

はじめまして、宮田＠富士ゼロックスと申します。

> 改行の無い複数行の文章中で^Nを押すと、next visual lineに行かず、next
> file lineへカーソルが移動してしまうというのになかなか慣れることがで
> きないのです。

以前にこんなものを作ってみました。

(defun previous-window-line (n)
  (interactive "p")
  (let ((cur-col
         (- (current-column)
            (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion (- n))
    (move-to-column (+ (current-column) cur-col))))

(defun next-window-line (n)
  (interactive "p")
  (let ((cur-col
         (- (current-column)
            (save-excursion (vertical-motion 0) (current-column)))))
    (vertical-motion n)
    (move-to-column (+ (current-column) cur-col))))

よかったら使ってみて下さい。
--
	宮田　隆＠富士ゼロックス サービス・コア開発部/SCD-3G
	KSP/R&D 8A7 TEL:044-812-8184 (EXT 7-983-6984)
	CIN:	Takashi Miyata:KSPB:Fuji Xerox
	INET:	miyata@netg.ksp.fujixerox.co.jp

--------------- 引用おわり ---------------------------------------------
--

               *- ishida@sharaku.nuac.nagoya-u.ac.jp (Eisuke Ishida) -*
               |    石田　栄介＠名古屋大学　工学研究科　建築学専攻    |
               |      　第５講座（建築構造設計講座）多賀研究室        |
               *- TEL(052)781-5111 (EX.6459) -------------------------*

