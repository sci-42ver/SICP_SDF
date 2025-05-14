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
    - Recommendations from [rfp](./rfp.pdf)
      - Emm... IMHO they are better done with *compiler background*...
        - [analysis and synthesis](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Introduction.html/node10.html#:~:text=During%20the%20analysis%20or%20synthesis,errors%20detectable%20by%20the%20compiler.) 
        - semantic search: [wikipedia](https://en.wikipedia.org/wiki/Semantic_search) is more than "matching patterns".
          > understanding the overall meaning of the query.
        - except for [point 4](https://en.wikipedia.org/wiki/Mechanism_design#Description)
          > deals with designing game forms (or mechanisms) to implement a given social choice function
          social choice function
          > Each person's preferences are combined in some way to determine which outcome is considered *better by society* as a whole.
    - IMHO "Scheme Type System" is a bit more acceptable for me without much compiler background.
      - The expected behavior is ~~like~~ different from Python type hint which [doesn't throw errors](https://stackoverflow.com/a/67412291/21294350).
      - See [typed/racket](https://docs.racket-lang.org/ts-guide/quick.html#%28part._.Using_.Typed_.Racket_from_the_.Racket_.R.E.P.L%29)
        - also [see](https://www.cs.ucf.edu/~leavens/ui54/docs/typedscm.html)
# Q&A
- What Scheme implementation should I use?
  I just follow the 6.5150 (6.945)/6.5151 (6.905) to use MIT/GNU Scheme. That's fine.
  I may also use Racket libs for some SICP exercises.
- What doc should I read?
  Maybe [this](https://stackoverflow.com/q/79098453/21294350) is helpful. So you can also try guile implementation although I am not familiar with that.
# Tips about Scheme usage.
- How to better search inside the Scheme output with `less` etc?
  See [this](https://unix.stackexchange.com/a/146428/568529) where IMHO `< <()` is better than `|` since the former will have the contents inside one file instead of a bit unstable pipe.
# Notice
- Here most of all exercises are independent like the reference SICP repo xxyzz does.
  However, it is better to make some extension introduced by the exercise available for latter exercises.
  - Anyway if you are interested, you can make them as dependent as possible.
    I didn't realize this problem until finishing SCIP chapter 4 and reading SDF chapter 4.
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
  to Nov 8, Exercise 4.42 and check the possible solution for the general 3.19 by Matt_Timmermans which is deleted later however.
  to Nov 12, section 4.3.3 (too slow...)
  to Nov 14, section 4.3
  to Nov 15, one lec
  to Nov 16, learn more about `call/cc`
  to Nov 17, give amb based on `sc-macro-transformer`
  to Nov 18, check coroutine said in c2 wiki and delimited continuation said in wikipedia coroutine.
  to Nov 20, give one feasible amb implementation functioning same as the book one.
  to Nov 21, found the guile doc saying much better than MIT/GNU Scheme doc about macro/syntax transformer like `syntax-rules` etc.
  to Nov 22, finish one rec and lab.
  to Nov 23, one rec.
  to Nov 26, finish SICP section 4.2, 4.4.
  to Nov 27, finish SICP exercise 4.76 (section 4.4.2 and 4.4.4).
  to Nov 29, exercise 4.77 (Emm... some exercise is a bit complex).
  to Dec 1, exercise 4.78.
  to Dec 2, 4.79.
  to Dec 4, finish section 4.4.1.
  to Dec 5, finish section 4.4.3.
  to Dec 6, finish CS_61A notes and rec which are much more trivial when having finished all SICP exercises.
  - Up to now, the main time is spent on reading the book and *schemewiki*.
    Emm about one month for each chapter... up to chapter 3.
## SDF
From Jul 17 to Aug 9, my efficiency is low (continued up to Aug 11, and then up to Aug 14 where I sometimes may think about weird things (still up to Aug 19)... ).
- From Jul 16 to Jul 18, read ps00 prerequisite contents.
  to Jul 21, finish ps00.
  to Aug 4, finish chapter 2.
  to Aug 5, finish ps01 (14 Feb to 23 Feb) (recommended to use 10 days. So exceed 4 days).
  From Aug 19 to Aug 22, finish ps02 (21 Feb to 1 Mar) (recommended to use 10 days. So exceed 3 days).
  From Aug 22 to Sep 1 (11 days), finish ps03 (28 February to 8 March) (recommended to use 10 days).
  From Sep 2 to Sep 11 (10 days), finish ps04 (6 March to 15 March) (recommended to use 10 days).
  From Dec 6 to Dec 9, section 4.1~4.3.
  to Dec 12, up to exercise 4.10 (a bit slow).
  to Dec 13, up to exercise 4.13.
  to Dec 16, up to exercise 4.16 partially.
  to Dec 21, *spend 4.5 days to deal with some problems for my parents* and finish 4.16.
  to Dec 22, finish 4.17 (too slow).
  to Dec 24, finish 4.18 (too slow).
  to Dec 25, finish the long exercise 4.19 before d.
  to Dec 28, finish exercise 4.19 d (too slow) and asked one SO question for verification.
  to Dec 30, check some 'SDF_exercises TODO's and ask one SE (Stack Exchange) question for commandline usage.
  to Dec 31, finish 4.20 trivially based on 4.19.
  to Jan 1, finish 4.11 and then trivially 4.21.
  to Jan 2, add one command to search for reference implementation (too slow).
  to Jan 3, read the Stack Exchange answers of the question I asked.
  to Jan 5, finish 4.7 (these 2 days I cooked meals by myself which took some time).
  to Jan 7, finish 4.9.
  to Jan 9, finish before Exercise 4.22 (too slow).
  to Jan 11, my right eye is carelessly hurt. Fortunately it can be cured by itself as the doctor says. I rest for 2 days.
  to Jan 12, finish Exercise 4.22 when what to do has been thought in one day previously.
  to Jan 14, sometimes my dad said something strange to me...; rest for one day.
  to Jan 16, finish Exercise 4.23 (too slow).
  to Jan 17, Exercise 4.24.
  to Jan 19, before Exercise 4.25 (too slow).
  to Jan 22, finish 1/4 of SDF exercise 4.23 predicate implementation (too slow).
  to Jan 23, finish SDF exercise 4.24 4_24_based_on_graph_match and half of SDF exercise 4.23 predicate implementation.
  to Jan 24, my dad said something strange sometimes (rest for one day).
  to Jan 25, almost finish SDF exercise 4.23.
  to Feb 1, *rest* for a week due to the high fever and the severe cough infected by my dad who has a bit of difficulty taking care of himself.
  to Feb 2, "finish SDF exercise 4.23 implementation with tests left to finish".
  to Feb 3, fix bugs for castling_tests.scm (4.23 implementation is a bit large).
  to Feb 4, fix bugs for 4.19...
  to Feb 5, fix bugs for castling_tests.scm which is related with 4.24.
  to Feb 9 noon (3.5 days), try to find one better time tracker than iOS notes to do time tracking. At last, I chose Coda similar to Notion but [better](https://www.reddit.com/r/PKMS/comments/14l76io/comment/mb9g8wg/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) (*Unrelated things*).
  to Feb 11, adjust coda based on daily requirements.
  to Feb 12, spend 29 mins to adjust coda in the morning while spending 1h 3 mins for SDF coding on Feb 9 (Time got by coda recording and the customized calculation using its internal formula).
  to Feb 14, Most of time are still used for adjusting coda (Use group and summary row in Coda to check this) except for Feb 12. That is 8 hrs 2 mins + 4 hrs vs 5 hrs 30 mins from 12 to 14 (So from Feb 6 to Feb 11 and from Feb 13 to 15 where Feb 14 I spent 5 hrs + 4 hrs = 9 hrs to check for the speed problem... Totally I spent 7 days to adjust coda). Here Feb 13 time is spent most (only consider those can be reduced) on adjusting coda (2h), taobao after sales problem (about 54 min).
  to Feb 15, 2 hrs 17 mins vs 58 mins.
  to Feb 16, 1 hr 12 mins vs 1 hr 45 mins.
  In summary, from Feb 6 to Feb 16, I spent 5 hrs 30 mins + 58 mins + 1 hr 45 mins = 8 hrs 13 mins for coding (*TODO* transform this to the normal day count).
  to Feb 22 noon, finish chapter 4 in the book.
  to Feb 27, finish up to considering the ideas for Exercise 5.1.
  Feb 28, rest for one day due to my dad saying strange things maybe because he is sad?
  to Mar 5, finish up to ex 5.6.
  to Mar 13, think of ex 5.7 based on a bit naive thoughts by self (*TOO MUCH TIME*).
  to Mar 20, finish `pratt_new_compatible_with_MIT_GNU_Scheme.scm` which is enough.
  See 
  ```bash
  ~/SICP_SDF/SDF_exercises/chapter_5$ git diff 1c446f44cf68f6f55cfd071fef148922ccc1a2d5...b013ebd2754ee5790db25581e752c807d9066f61 --stat -- .
  ...
   chapter_5/5_7_pratt_operator_precedence_parser/python_demo/pratt.py                                       |  114 +++++++
  ...
   chapter_5/5_7_pratt_operator_precedence_parser/scheme_demo/compatible_lib.scm                             |   73 +++++
  ...
   chapter_5/5_7_pratt_operator_precedence_parser/scheme_demo/orig/pratt_new.scm                             |  650 +++++++++++++++++++++++++++++++++++++++
   chapter_5/5_7_pratt_operator_precedence_parser/scheme_demo/orig/pratt_new_orig.scm                        |  359 +++++++++++++++++++++
  ...
   chapter_5/5_7_pratt_operator_precedence_parser/scheme_demo/syntax_tests/free_identifier.scm               |   10 +
  ...
   chapter_5/perl_tests/my_in_for.perl                                                                       |    2 +
  ...
  ```
  In a nutshell, here I checked 
  0. thegreenplace 
  1. & siod implementation for Pratt parsing. 
  2. I also checked for one doc problem shown inside `free_identifier.scm` 
  3. and one former question asked before for the parenthesis matching algorithm used in that naive implementation (see `perl_tests`).
  Also see `git diff 1c446f44cf68f6f55cfd071fef148922ccc1a2d5...b013ebd2754ee5790db25581e752c807d9066f61 --dirstat=0 -- .` where `chapter_5/5_7_related_python_behavior/` is mainly about the Python expression grammar checking.
  to Mar 26, check oilshell blogs (*UNNECESSARY*). 
  to Mar 29, try to implement re's `?<!` (i.e. `neg-look-behind`) etc using racket (*UNNECESSARY*).
  to Apr 6, check oilshell blogs (*UNNECESSARILY TOO MUCH*) and check QAs asked by me.
  to Apr 14, port oilshell implementation to Scheme (*UNNECESSARY*) and rest for 3 days.
  to Apr 19, port those inside the former `pratt_new_compatible_with_MIT_GNU_Scheme.scm` (*UNNECESSARY*).
  to Apr 22, add `SentinelLib.scm` etc (*UNNECESSARY*).
  to Apr 28, finish all *basic* grammar structure in Python expression (*UNNECESSARY*).
  to May 2 (4 days), fix bugs related with `pratt_new_compatible_with_MIT_GNU_Scheme.scm` (*UNNECESSARY*). (bug/implementation time = 4/(Apr 28-Apr 6)=0.18)
  to May 4, finish the rest tests for the additional grammar, fix ex 5.5 compatibility problem (*UNNECESSARY*).
  (4+30+11=45 days can be thought as wasted...)
  to May 6, give one summary for the former perl QAs (IMHO better to check those *after a bit long time*. So we can give one check without much influence by *historic thoughts for that old problem* which may be wrong. And that check can be also even clear after we think about other unrelated things to make the head clear without being confused too much when *sticking into* that former old problem.).
  to May 14, finish before ex 5.8 (*CAN BE RECUCED*) with much time spent on solving with the historic physical problem which should be solved when 17 yrs. That is mainly due to *intellectual poverty* instead of financial poverty. The former means something like appearance is not that important compared with the learning rank even we can *temporarily* not care about the appearance but just spend days and nights studying until almost going mad. 
  I have to say I may probably have a bit of bipolar disorder since my energy is a bit like roller coaster. Or maybe that is just due to I spend long time doing one thing, i.e. self-studying, without having much entertainment besides watching drama sometimes. But IMHO that entertainment has been like paralysis for a long time. I lack money to do something I really wants to do, or maybe just due to human rights lacked in one *centralized* country.
  - Notice the above ps recommendation time have overlap, so my efficiency seems to be very low...
  - Up to now, the main time is spent on reading the book and finishing chapter exercises
### @%Chapter 4 time review (my efficiency decreases a lot during this range)
- From Dec 6 to Dec 9, the efficiency is normal.
  to Dec 16, I should finish all before section 4.5, but just until exercise 4.16, the speed is *slow*...
  to Dec 21, vaguely 0.5 day to read the book.
  From Dec 22 to Dec 28, finish exercise 4.19 d (*slow*).
  From Dec 29 to Dec 31, check some 'SDF_exercises TODO's and one SE question I asked.
  Jan 1, finish 4.11 and then trivially 4.21.
  From Jan 2 to Jan 3, one SE question I asked.
  to Jan 9, finish before section 4.5 (So totaly `16-6+1+0.5+28-22+1+3/2+1+9-4+1=27.0` where 3/2 is one vague time estimation. So I only reached *at most `10/27=0.37` of the required efficiency*...).
  Jan 12 to Jan 13, Exercise 4.22 (*slow*)
  Jan 15 to Jan 19, almost finish SDF exercise 4.25
  to Jan 23, finish 4.23 predicate implementation which is *not needed by the book* but just done to see how graph-match can do things done in chapter 2 chess rules.
  Jan 25, almost finish SDF exercise 4.23.
  Feb 2, finish SDF exercise 4.23 with tests left.
  to Feb 5, fix bugs.
  From Feb 6 to Feb 16,  8 hrs 13 mins for coding (see the above *TODO*).
  to Feb 18, finish all tests.
  to Feb 19, finish SDF exercise 4.25.
  to Feb 21, review chapter 4 (*slow*).
  So I spent `3-2+1+9-5+1+3-0+1+1+1+5-3+1=16` days where I did household by myself. And I spent `21-16=5` days plus 8 hrs 13 mins additionally for section 4.5 (*so slow*)...
  - From Dec 24 (vaguely, the railway ticket app doesn't support searching for history before one month ago) to Jan 16, my mom went to my grandma's home, so I did all household which vaguely took `(Hours(13)+Minutes(22))/11*(Date(2025, 1, 16)-Date(2024,12,24)+1)=1 day 5 hrs 9 mins` based on coda data (2/6 to 2/14: 10 hrs 24 mins, 2/15 to 2/16: 2 hrs 58 mins, so totally 13 hrs 22 mins, i.e. 1 hrs 12 mins each day). (*TODO*: consider these time for efficiency calculation)
  - From Feb 17 to Feb 22 (6 days), I was a bit regretful for something I haven't done in junior middle school.
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
## other possible notes
- https://buffer.thebitmage.com/%2F20240410114903-mit_ocw_6_945_aiasp.html
## course 6.5151 (6.905)
1. I *can't find the pdf lecture* by "mit 6.5151 lecture filetype:pdf".
2. It seems to have no homework by '6.5151 "homework"' (with only Red Tape pdf), similarly for Exam by 'mit 6.5151 "exam"' and Quizzes by "mit 6.5151 Quiz".
   It *only* has *problem set / assignment*.
   - By seeing their pdf's, they are mainly directly book exercises.
- [old ~~project~~ assignment implementation 2009 (partial)](https://buffer.rajpatil.dev/%2F20240410114903-mit_ocw_6_945_aiasp.html) and [2019 (only have the project solution by bmitc)](https://github.com/bmitc/mit-6.945-project) (weird still [can't find its fork](https://github.com/bmitc/mit-6.945-project/forks?include=active&page=1&period=&sort_by=stargazer_counts))
  TODO [final-project](https://groups.csail.mit.edu/mac/users/gjs/6.945/final-project.pdf) needs team and is a bit general about "symbolic-manipulation software" (no suggestion for project types).
  - red-tape doesn't say what "some ideas" are (also for the above final-project link, FAQ and Overview).
    > If you don’t come up with a great IDEA yourself, we *have some ideas that you might pursue*. You will be expected to write elegant code that can be easily read and understood by us
  - The 1st link seems to be https://buffer.thebitmage.com/%2F20240410114903-mit_ocw_6_945_aiasp.html now.
  - bmitc's is already [ps9](https://groups.csail.mit.edu/mac/users/gjs/6.945/psets/ps09/ps.pdf) at least for actor.
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
## related md files
- ```bash
  $ find . -regex '.*\.md' -o \( -type d \( -path ./QA_templates -o -path ./sdf_mbillingr -o -path ./SICP -o -path ./comment_archive -o -path ./exercise_codes -o -path ./lecs -o -path ./6.945_assignment_solution -o -path ./chebert_software-design-for-flexibility \) -prune \) | grep -v md
  ./comment_archive
  ./exercise_codes
  ./lecs
  ./SICP
  ./6.945_assignment_solution
  ./sdf_mbillingr
  ./chebert_software-design-for-flexibility
  ./QA_templates
  $ find . -regex '.*\.md' -o \( -type d \( -path ./QA_templates -o -path ./sdf_mbillingr -o -path ./SICP -o -path ./comment_archive -o -path ./exercise_codes -o -path ./lecs -o -path ./6.945_assignment_solution -o -path ./chebert_software-design-for-flexibility \) -prune \) | grep md
  ./sicp_exercise.md
  ./sicp_notes.md
  ./README.md
  ./SDF_notes.md
  ./SDF_exercises/chapter_4/4_17.md
  ./SDF_exercises/README.md
  ```
  Here only `SDF_notes.md` and `SDF_exercises/README.md` are related.
# TODO
- What is the purpose of "sicp_codes" dir?