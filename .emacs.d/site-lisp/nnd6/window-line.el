From ishida@sharaku.nuac.nagoya-u.ac.jp Mon Jan 24 16:09:15 1994
Newsgroups: fj.editor.emacs
From: ishida@sharaku.nuac.nagoya-u.ac.jp (Eisuke Ishida)
Subject: Re: cursor moving
In-Reply-To: ishida@sharaku.nuac.nagoya-u.ac.jp's message of Wed, 19 Jan 1994 03: 58:58 GMT
Organization: Taga&Fukuwa Lab., Dept. of Architecture, Nagoya Univ., Japan
Distribution: fj
Date: Thu, 20 Jan 1994 12:34:15 GMT


���ġ�̾�Ų���ؤǤ���

���ε�������Ƥ����塢��������οͤ���ֻ�Ⲽ������
�Ȥ������ƤΥ᡼���ĺ���ޤ�����
��Ϥ���פ��⤤�褦�Ǥ��͡�

Ʊ�ͤ��׵᤬���������ޤ��ߤ��뤫���Τ�ʤ��Τǡ�
�����ˡ��彣��ؤΰ�夵�󤫤�ĺ�����᡼������
����ʸ����ʬ����Ƥ�����ĺ���ޤ���
��ϡ������ .emacs �˥��ԡ����Ƥ��β���

	(global-set-key "\C-p" 'previous-window-line)
	(global-set-key "\C-n" 'next-window-line)

�ȣ����դ��ä����顢�����̤�ư���褦�ˤʤ�ޤ�����
�ʤȤ��äƤ⡢elisp �ϥ��ǿͤǤ�����äȥ��쥬��Ȥ�
�����������ʤ�,�ɤʤ��������Ʋ�������(_o_) ��

�� \C-a, \C-e, \C-k ���ˤϡ��б����Ƥ��ʤ��ߤ����Ǥ��͡�

--------------- ���ѤϤ��� ---------------------------------------------
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

> ��¼��������ؤȿ����ޤ���

�Ϥ���ޤ��ơ����ġ��ٻΥ���å����ȿ����ޤ���

> ���Ԥ�̵��ʣ���Ԥ�ʸ�����^N�򲡤��ȡ�next visual line�˹Ԥ�����next
> file line�إ������뤬��ư���Ƥ��ޤ��Ȥ����Τˤʤ��ʤ�����뤳�Ȥ���
> ���ʤ��ΤǤ���

�����ˤ���ʤ�Τ��äƤߤޤ�����

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

�褫�ä���ȤäƤߤƲ�������
--
	���ġ�δ���ٻΥ���å��� �����ӥ���������ȯ��/SCD-3G
	KSP/R&D 8A7 TEL:044-812-8184 (EXT 7-983-6984)
	CIN:	Takashi Miyata:KSPB:Fuji Xerox
	INET:	miyata@netg.ksp.fujixerox.co.jp

--------------- ���Ѥ���� ---------------------------------------------
--

               *- ishida@sharaku.nuac.nagoya-u.ac.jp (Eisuke Ishida) -*
               |    ���ġ��ɲ��̾�Ų���ء����ظ���ʡ����۳��칶    |
               |      ���裵�ֺ¡ʷ��۹�¤�߷׹ֺ¡�¿�츦�漼        |
               *- TEL(052)781-5111 (EX.6459) -------------------------*

