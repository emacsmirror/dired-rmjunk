;;; dired-rmshit.el --- A port of Jakub Klinkovský's rmshit.py to Dired.

;; Copyright (C) 2019 Jakob L. Kreuze

;; Author: Jakob L. Kreuze <zerodaysfordays@sdf.lonestar.org>
;; Version: 1.0
;; Package-Requires (dired)
;; Keywords: dired
;; URL: https://git.sr.ht/~jakob/dired-rmshit

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; dired-rmshit is a port of Jakub Klinkovský's rmshit.py to Dired. The
;; interactive function, `dired-rmshit' will mark all files in the
;; current Dired buffer that match one of the patterns specified in
;; `dired-rmshit-shitty-files'. The tool is intended as a simple means
;; for keeping one's home directory tidy -- removing "junk" dotfiles.

;; The original implementation of rmshit.py can be found at:
;; <https://github.com/lahwaacz/Scripts/blob/master/rmshit.py>

;;; Code:

(defgroup dired-rmshit ()
  "Remove shitty files with dired."
  :group 'dired)

(defcustom dired-rmshit-shitty-files
  '(".adobe" ".macromedia" ".recently-used"
    ".local/share/recently-used.xbel" "Desktop" ".thumbnails" ".gconfd"
    ".gconf" ".local/share/gegl-0.2" ".FRD/log/app.log" ".FRD/links.txt"
    ".objectdb" ".gstreamer-0.10" ".pulse" ".esd_auth" ".config/enchant"
    ".spicec" ".dropbox-dist" ".parallel" ".dbus" "ca2" "ca2~"
    ".distlib" ".bazaar" ".bzr.log" ".nv" ".viminfo" ".npm" ".java"
    ".oracle_jre_usage" ".jssc" ".tox" ".pylint.d" ".qute_test"
    ".QtWebEngineProcess" ".qutebrowser" ".asy" ".cmake" ".gnome"
    "unison.log" ".texlive" ".w3m" ".subversion" "nvvp_workspace")
  "Default list of files to remove. Current as of f707d92."
  :type '(list string))

(defun dired-rmshit ()
  "Marks all files in the current dired buffer that match one of
the patterns in `dired-rmshit-shitty-files'."
  (interactive)
  (when (eq major-mode 'dired-mode)
    (save-excursion
      (let ((files-marked-count 0))
        (dolist (file (directory-files dired-directory))
          (when (member file dired-rmshit-shitty-files)
            (setq files-marked-count (1+ files-marked-count))
            (dired-goto-file (concat (expand-file-name dired-directory) file))
            (dired-flag-file-deletion 1)))
        (message (if (zerop files-marked-count)
                     "No shitty files found :)"
                   "Shitty files marked."))))))

(provide 'dired-rmshit)
;;; dired-rmshit.el ends here
