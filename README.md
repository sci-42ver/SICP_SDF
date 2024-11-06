# What this repo contains
- notes for SICP and SDF
- SICP 
  - project 4 needed by SICP lec
  - notes for SICP 6.001 lec and rec with solutions (if unavailable for some section, use 6.037)
    - also for CS61A notes and labs with solutions
  - CS61A Unit 0 solution and notes
- SDF 
  - exercise solutions
  - 6.5150 ps solution
  - TODO 6.5150 project demo
# How long I have taken to read these books
## SICP
- From Jun 2 to Jul 2, chapter 1 is finished.
  to Jul 11, up to chapter 2.1.
  to Jul 13, review history chapter recitations, etc.
  to Jul 15, up to chapter 2.2.1.
  to Jul 16, finish related history labs, lecs, recs. (15 days)
  From Aug 5 to Aug 7, finish chapter 2.2.2.
  to Aug 10, 2.2.3.
  to Aug 11, 2.2.
  to Aug 12, 2.3.2.
  to Aug 13, 2.3.
  to Aug 15, related lec, rec and labs.
  to Aug 16, 2.5.2 and 2.5.3.
  to Aug 18, finish chapter 2. (14 days)
  From Sep 12 to Sep 13, section 3.2
  to Sep 15, 2 CS61A week notes and labs.
  to Sep 19, section 3.3 up to exercise 3.12~3.27 most of time to do exercises.
  to Sep 20, one CS61A week
  to Sep 25, read 6.001 notes lec11 to lec16.
  to Sep 28, 6.001 OOP project.
  to Sep 30, section 3.3.
  to Oct 2, section 3.4
  to Oct 3, one CS61A week
  to Oct 5, Exercise 3.50~exercise 3.57.
  to Oct 7, https://stackoverflow.com/questions/78597962/1-01e-100-1-in-mit-scheme/78626541#comment138620089_78597962
  to Oct 10, section 3.5.3. (the speed is a bit slow.)
  to Oct 12, chapter 3 is finished.
  to Oct 13, one CS61A week
  to Oct 15, one lec, 2 recs and partly section 4.1.
  From Oct 10 to Oct 25, section 4.1... (too slow)
  to Oct 28, 2 lecs and related recs plus CS_61A/week12 (*should be faster* since one chapter half month is one reasonable speed, so each section has at most 4 days to read...).
  to Oct 30, CS_61A/week13.
  to Nov 2, section 4.2 with 2 exercises left.
  to Nov 3, section 4.2.
  to Nov 5, check the solution for the [general 3.19](https://stackoverflow.com/q/79155452/21294350) which is related with 4.34 implicitly (I should ask the question in QA after being stuck for a too long time like many hours... especially when that answer doesn't get many upvotes).
  - Up to now, the main time is spent on reading the book and *schemewiki*.
    Emm about one month for each chapter... up to chapter 3.
## SDF
From Jul 17 to Aug 9, my efficiency is low (continued up to Aug 11, and then up to Aug 14 where I sometimes may think about weird things (still up to Aug 19)... ).
- From Jul 16 to Jul 18, read ps00 prerequisite contents.
  to Jul 21, finish ps00.
  to Aug 4, finish chapter 2.
  to Aug 5, finish ps01 (14 Feb to 23 Feb) (recommended to use 10 days. So exceed 4 days).
  From Aug 19 to Aug 22, finish ps02 (21 Feb to 1 Mar) (recommended to use 10 days).
  From Aug 22 to Sep 1 (11 days), finish ps03 (28 February to 8 March) (recommended to use 10 days).
  From Sep 2 to Sep 11 (10 days), finish ps04 (6 March to 15 March) (recommended to use 10 days).
  - Notice the above ps recommendation time have overlap, so my efficiency seems to be very low...
  - Up to now, the main time is spent on reading the book and finishing chapter exercises
# SICP
Notice I also have exercise solutions in `sicp_exercise.md` and exercise_codes/ repo besides the SICP submodule.

[booklist](https://billthelizard.blogspot.com/2008/12/books-programmers-dont-really-read.html)
better read it [with the adequate maths background](https://tekkie.wordpress.com/2018/04/03/a-word-of-advice-before-you-get-into-sicp/)

I will use [official wiki](https://web.archive.org/web/20240228152042/http://community.schemewiki.org/?sicp-solutions) (http://community.schemewiki.org/?sicp-ex-1.27 resumed at least when 2024-6-21) as the main part. 

## why I still learn sicp in 2024. See [this](https://github.com/sci-42ver/Discrete_Mathematics_and_Algorithm/tree/master/CRLS#why-it-is-still-useful-also-see-why-it-is-discontinued) especially cemerick.

## Scheme interpreter choice
Notice [Racket](https://gitlab.com/utkarsh181/sicp)/[PLTScheme](https://tekkie.wordpress.com/2011/07/26/just-a-quick-note-about-sicp-mutable-pairs-and-pltscheme/) doesn't have *mutable pairs*.
from tekkie.wordpress
> This change only applies to the issue of immutable vs. mutable pairs. The dev. team made this decision, because in their view it made Scheme more of a pure functional language

I choose R5RS as Racket is based on it and 6.5151 (6.905) Red Tape Memo recommends R5RS.

I use MIT/GNU Scheme.

## what I skipped
- https://web.archive.org/web/20150318225436/http://schemecookbook.org/ since I don't plan to learn scheme *specially*
## lacking exercise solutions
- 5.51~52
## book
- sicp from [this 2019 course material although "The End of an Era" says 6.001 is obsolete since 2008](https://web.mit.edu/6.001/6.037/sicp.pdf) ([newer 2.andresraba6.6](https://sarabander.github.io/sicp/) [without](https://github.com/sarabander/sicp-pdf/tree/master) the corresponding pdf). Also see [this](https://www.cliki.net/SICP) and [this](https://news.ycombinator.com/item?id=13918465) for other forms.
  [*official*](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-5.html) ([archive](https://web.archive.org/web/20170710220837/https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-1.html))
  - [interactive](https://xuanji.appspot.com/isicp/1-1-elements.html)
## prerequisite
- [no prerequisite](https://github.com/ossu/computer-science/issues/1081) is needed although [tekkie](https://tekkie.wordpress.com/2018/04/03/a-word-of-advice-before-you-get-into-sicp/) says more advanced maths is needed.
  Also see [history Course Catalogue](https://dome.mit.edu/handle/1721.3/187889), i.e. history_mit_Course_Catalogue.pdf.
- newer course needs [programming experience](https://web.mit.edu/6.001/6.037/) like [6.145 A Brief Introduction to Programming in Python](https://hz.mit.edu/catsoop/6.145) or [6.178 about Java](https://ocw.mit.edu/ans7870/6/6.005/s16/getting-started/java.html) ([6.005](https://web.mit.edu/6.005/www/archive/))
## [errata](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/errata.html)
- So we better read the HTML version to avoid ambiguity.
  > is is the second edition  book, from Unofficial Texinfo Format.
  > e freely-distributed official -and- format was first con-verted personally to Unofficial Texinfo Format () version 1
  > Also, it’s quite possible that *some errors of ambiguity were introduced* during the conversion
  - older computer seems to read the book using Emacs due to its performance.
    > You are probably reading it in an Info hypertext browser, such as the Info mode of Emacs. You might alternatively be reading it TEX-formaed on your screen or printer, though that would be silly.
## other solutions
- ~~almost full~~ (all skipped since they lack exercise solutions existing in this repo)
  - detailed
    - [1](https://www.inchmeal.io/sicp/ch-1/notes.html) no 1.14, etc.
    - [2](https://zv.github.io/sicp-chapter-4) no 4.78, etc.
  - [3](https://mk12.github.io/sicp/exercise/5/4.html) no Exercise 5.23⁠
  - [4](https://github.com/jlollis/sicp-solutions/tree/master/Chapter%201%20Exercises) only has 5.01 for chapter 5.
  - ~~[**not archived**](https://web.archive.org/web/20120126125952/http://sicp.org.ua/sicp/Chapter5) from https://github.com/fgalassi/cs61a-sp11?tab=readme-ov-file~~
  - https://web.archive.org/web/20131112031244/http://eli.thegreenplace.net/2008/04/18/sicp-section-55/ skips after 5.43.
  - from wiki
    - https://github.com/rparnas/sicp-ex/blob/master/exercises/5.50.ss lacking 5.50
      Without useful links
    - https://github.com/abdulapopoola/SICPBook/tree/master/Chapter%205/5.5 same as the above
      Without useful links
    - https://github.com/postboy/sicp-homework/tree/master I don't understand its dir naming.
      links to one non-English *general* blog
    - https://github.com/ivanjovanovic/sicp/tree/master/5.5 lacking much
      - https://github.com/Pluies/SICP/blob/master/Chapter%201.scm not readable with one chapter one file and lacking something like 1.45.
      - https://web.archive.org/web/20150926220244/https://wqzhang.wordpress.com/sicp-solutions/ from 2017 link
        lacks chapter 5.
        - http://gregsexton.org/2012/11/26/sicp-in-clojure.html skipped due to language
        - http://hackerretreat.com/start-sicp-trek/ not archived
        - https://voom4000.wordpress.com/2015/08/10/sicp-solutions/ skipped (See below)
        - https://web.archive.org/web/20120122082510/http://www.einverne.info/sicp-solutions.html
          - https://web.archive.org/web/20121216011814/http://karetta.jp/book-cover/YetAnotherSICPAnswerBook up to chapter 3
          - https://web.archive.org/web/20120126125952/http://sicp.org.ua/sicp/Chapter5 (See above)
          - https://web.archive.org/web/20111105110411/http://weimalearnstoprogram.blogspot.com/ up to chapter 3 
        - https://web.archive.org/web/20101023223956/http://www.zerobeat.in/2010/03/14/sicp-study/ -> https://github.com/vu3rdd/sicp/blob/master/README no chapter 5
          - [trackback](https://yaro.blog/newsletters/what-is-a-trackback-and-how-can-it-increase-your-blog-traffic/) similar to reference.
          - https://web.archive.org/web/20100501084331/http://wiki.drewhess.com/wiki/Category:SICP_solutions -> https://github.com/dhess/sicp-solutions/tree/master up to chapter 3
      - https://web.archive.org/web/20140819201738/http://eli.thegreenplace.net/category/programming/lisp/sicp/ 2014 link
- from wiki https://github.com/cxphoe/SICP-solutions almost same as this repo lacking 5.51~52
- maybe full
  - [1](https://lockywolf.wordpress.com/2021/02/08/solving-sicp/#org64d8b79) -> https://gitlab.com/Lockywolf/chibi-sicp
    It has [exercise 5.52 code in the doc](https://gitlab.com/search?search=compile-and-dont&nav_source=navbar&project_id=14144079&search_code=true&repository_ref=master)
- maybe full with many language implementations
  - [1](https://www.reddit.com/r/lisp/comments/qqwfh2/sicps_solution_in_racket_and_guile/) seems to lacking 5.51,52 and 5.40, etc., which are contained in this repo.
- only chapter 1
  - [1](https://sicp-solution.readthedocs.io/en/latest/chp1/1.2.html#exercise-1-24)
  - [2](https://git.sr.ht/~acsqdotme/sicp/tree)
  - [only 1.1](https://lucidmanager.org/productivity/page/4/)
  - [with maths](https://discuss.criticalfallibilism.com/t/justin-does-sicp/96/33)
  - [3](https://sicp-solutions.readthedocs.io/en/latest/)
- chapter 1,2
  - [1](https://notabug.org/ZelphirKaltstahl/old-racket-sicp-solutions)
  - [2](https://kendyck.com/page/2/)
  - [3](https://voom4000.wordpress.com/2015/08/10/sicp-solutions/)
  - [with many links](https://billthelizard.blogspot.com/2009/10/sicp-challenge.html)
  - [4](https://notes.abrocadabro.com/learning/courses/sicp/)
  - [5](https://github.com/alex4814/sicp-solution)
  - https://web.archive.org/web/20160312023725/https://kendyck.com/solutions-to-sicp/ from the 1st in https://web.archive.org/web/20181015000000*/https://kendyck.com/solutions-to-sicp/
- chapter 1,2,3
  - [1](https://quirksand.nfshost.com/topics/sicp.html)
  - from wiki
    https://codeberg.org/ChristopherChmielewski/sicp
- chapter 1,2,3,4
  - [1](https://github.com/qiao/sicp-solutions/tree/master/chapter4)
  - [2](https://wizardbook.wordpress.com/solutions-index/)
  - [3](https://adrianstoll.com/post/sicp-structure-and-interpretation-of-computer-programs-solutions/)
- only partially
  - [1](https://tekkie.wordpress.com/?s=sicp&submit=Search)
## How to learn
- [see](https://github.com/abrantesasf/sicp-abrantes-study-guide?tab=readme-ov-file)
  - I skipped
    https://web.archive.org/web/20221024062249/https://code-and-cocktails.herokuapp.com/blog/2014/07/06/what-i-have-re-learned-from-sicp/
  - The most of links are covered in this doc and the related doc in DMIA_CRLS repo.
## TODO
- [programming assignments](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/psets/index.html) from [the official page](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/index.html)
- ~~[community-wiki](http://community.schemewiki.org/?sicp-ex-1.18)~~
- how to make vim maybe [directly running the code](https://www.neilvandyke.org/sicp-texi/) in the texinfo/info ("the Info hypertext format that can be viewed in Emacs").
# SDF
> This book is built on the *lectures and problem sets* that are now used in our class.
## TODO
- https://lobste.rs/s/m6gnaq/review_software_design_for_flexibility from https://www.reddit.com/r/scheme/comments/t4bbrq/have_you_read_the_book_software_design_for/
## course 6.5151 (6.905)
1. I *can't find the pdf lecture* by "mit 6.5151 lecture filetype:pdf".
2. It seems to have no homework by '6.5151 "homework"' (with only Red Tape pdf), similarly for Exam by 'mit 6.5151 "exam"' and Quizzes by "mit 6.5151 Quiz".
   It *only* has *problem set / assignment*.
   - By seeing their pdf's, they are mainly directly book exercises.
- [old ~~project~~ assignment implementation 2009 (partial)](https://buffer.rajpatil.dev/%2F20240410114903-mit_ocw_6_945_aiasp.html) and [2019 (only have the project solution)](https://github.com/bmitc/mit-6.945-project) (weird still [can't find its fork](https://github.com/bmitc/mit-6.945-project/forks?include=active&page=1&period=&sort_by=stargazer_counts))
  TODO [project](https://groups.csail.mit.edu/mac/users/gjs/6.945/final-project.pdf) needs team and is a bit general about "symbolic-manipulation software".
  - It doesn't say what "some ideas" are (also for https://groups.csail.mit.edu/mac/users/gjs/6.945/red-tape.pdf, FAQ and Overview).
    > If you don’t come up with a great IDEA yourself, we *have some ideas that you might pursue*. You will be expected to write elegant code that can be easily read and understood by us
- I only find one 2009 [video lectues](https://archive.org/details/adventures-in-advanced-symbolic-programming)
  - https://news.ycombinator.com/item?id=23599794
    > but the entire class is centered around psets
  - [This](https://github.com/prakhar1989/awesome-courses?tab=readme-ov-file) is [not archived](https://web.archive.org/web/20240513002054/https://camo.githubusercontent.com/afb2fd943e89b86299f1e2c61e629fe0e5a3b8ecde5221e683445077b0754101/68747470733a2f2f6173736574732d63646e2e6769746875622e636f6d2f696d616765732f69636f6e732f656d6f6a692f756e69636f64652f31663464642e706e67)
    but it seems to be still [the video](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-anonymized-urls)
- [AI_preq_sicp]
  > if you want to do Sussman's more recent books like SDF you're going to have to use the latest mit-scheme anyway
- pset / PS09 -> assignment.
### what to learn
- https://groups.csail.mit.edu/mac/users/gjs/6.945/red-tape.pdf
  - > The grades for this subject will be determined by a combination of classroom participation, *homework, and project work*
    > To receive an “A” in this subject you will have to work *all of the problem sets and prepare a good final project*. We expect you to be at every class and to work every problem set.
    So do "problem sets" and the "final project".
### SDF
- "course using Software Design for Flexibility" has *no candidates* while "course using SICP" has.
- [This](https://www.reddit.com/r/scheme/comments/zmfwjb/the_book_software_design_for_flexibility_lukewarm/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) is *not helpful* up to [this](https://www.reddit.com/r/scheme/comments/zmfwjb/comment/j0iq1d3/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) sorted by Best when giving one brief reading.
### [overview](https://groups.csail.mit.edu/mac/users/gjs/6.945/overview.pdf)
- > Substantial *weekly programming assignments and a final project* are an *integral* part of the subject.
### [red-tape](https://groups.csail.mit.edu/mac/users/gjs/6.945/red-tape.pdf)
- Assignments
- project
  > If you don’t come up with a great IDEA yourself, we have *some ideas that you might pursue*. You will be expected to write elegant code that can be *easily read and understood* by us. You must supply a clear *English explanation* of how your software works, and a set of *test cases* *illustrating and testing* its operation. You will present a brief summary and demo in class near the end of the term.
- homework may mean assignment
  > by a combination of classroom participation, homework, and project work
- Collaborative work
  > *involve themselves in all aspects* of the work. ... you should indicate the names of any collaborators for *each part* of the assignment
### Don't Panic!
> Sections 2, 3, 4, 6, and 7 are essential. Please follow these *thoroughly*.
#### 3.1
- advantages of edwin
  > offers a *better* integrated scheme *debugger* than emacs
  disadvantages (i.e. advantages of emacs)
  > based on an *older* version of emacs (version 19) and has not been developed much since.
  > *no online presence or community*
  > fairly anemic *library*
  - disadvantages of emacs
    > uses elisp, a fairly *kludgy dialect* of lisp, as an extension language
    > not as much integration with mit-scheme than edwin
  - I will just use vscode and `drracket` as the 6.001/6.037 course does.
  - So I will skip
    > To view the tutorial, execute:
    > For a tour of what you can do, go here:
    > You should read all the key bindings of *both the scheme source code mode and the scheme REPL mode*
- TODO
  > how do you figure out that C-M-x will evaluate the scheme form at your cursor if you don't already know that
  `C-h k` -> `C-M-x` will output "... is undefined".
- kw
  > LISP is almost as old as programming itself, having been created just *a year after Fortran*, the first "high-level" computer language.
  - REPL (similar to python)
    > The most important thing about programming using scheme, and any LISP for that matter, is to use the *REPL*.
    > Generally, as you are programming in scheme, you will have one window which contains the code you are writing, and one window which serves as your REPL.
    > You write some code (perhaps a single function), evaluate that code, then *move over to the repl* and experiment with the code you just wrote. Based on your repl interaction, you *go back to your code* and make changes, and then the cycle repeats. 
    > You can also run some tests in the REPL and then *copy the results of those tests into your main source file*, to use as documentation of what the function is supposed to do for certain inputs. This will be an effective way to prepare psets – you write code, then copy the answers to the problem from the REPL back to your source file.
  - > If this were a C or Java program you would have to write a small *test-harness*, re-compile and then run the program again to do what you have just done.
- TODO I don't know how to copy in emacs. [The top 2 answers by Daniel and Steven D](https://unix.stackexchange.com/q/6640/568529) fail.
- > You can always start the debugger at a *scheme REPL* by evaluating
  i.e. it is inside MIT-Scheme. So it may have less functions than `drracket`.
- > If you start the debugger in this way, then you will get a very nice looking window that constantly displays many of the things you could otherwise access through the commands you *have just been shown*. Try it out; it's neat!
  In a summary the key useful feature is `v`. TODO how to do that in `drracket`?