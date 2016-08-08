;;++ GNUS
(setq network-coding-system-alist '(("nntp" . (junet-unix . junet-unix))
				    (110 . (no-conversion . no-conversion))
				    (25 . (no-conversion . no-conversion))))
(setq gnus-nntp-server my-nntp-server)
(setq nntp-buggy-select nil)
(setq gnus-local-timezone "JST")
(setq gnus-news-system "Inn")
(setq gnus-local-organization "Software Business Development Center
        Sharp Corp.,Yamato-kohriyama,Nara,Japan")
(setq gnus-local-domain my-domain)
(setq gnus-use-generic-from t)
;;
;;(setq gnus-nntp-service 119)
(setq gnus-startup-file "//beam/nnd6/.newsrc")
