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

;; This is the test suite for `dired-rmjunk', separated from `dired-rmjunk.el'
;; so that loading `ert' isn't a requirement to use the tool.

;; The suite can be run with the following shell command:

;; emacs -Q --batch --directory ./ --directory ./t --load t/dired-rmjunk-test.el --funcall ert-run-tests-batch-and-exit

;;; Code:

(require 'dired-rmjunk)
(require 'ert)

(ert-deftest dired-rmjunk-test-dir-name ()
  (should (equal (dired-rmjunk--dir-name ".FRD/links.txt")
                 ".FRD/"))
  (should (equal (dired-rmjunk--dir-name ".local/share/recently-used.xbel")
                 ".local/share/"))
  (should (equal (dired-rmjunk--dir-name ".asy")
                 nil)))

(ert-deftest dired-rmjunk-test-file-name ()
  (should (equal (dired-rmjunk--file-name ".FRD/links.txt")
                 "links.txt"))
  (should (equal (dired-rmjunk--file-name ".local/share/recently-used.xbel")
                 "recently-used.xbel"))
  (should (equal (dired-rmjunk--file-name ".asy")
                 ".asy")))

(ert-deftest dired-rmjunk-test-directories-in-patterns ()
  (should (equal (dired-rmjunk--directories-in-patterns
                  '(".local/share/recently-used.xbel"
                    "Desktop"
                    ".thumbnails"))
                 '(".local/share/")))
  (should (equal (dired-rmjunk--directories-in-patterns
                  '(".distlib"
                    ".bazaar"
                    ".bzr.log"))
                 nil))
  (should (equal (dired-rmjunk--directories-in-patterns
                  '(".local/share/gegl-0.2"
                    ".FRD/app.log"
                    ".FRD/links.txt"))
                 '(".local/share/" ".FRD/"))))
