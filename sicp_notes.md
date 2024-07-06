This seems to one problem caused by code changes as https://lore.kernel.org/git/20170530170557.GA2798@google.com/T/ says. "by first pushing changes in each submodule manually" works for me.

# Notice
- I am using Ryzen 4800H which is related the test result in this repo.
- I won't dig into all *complexity computation* in this book since this is *not the target* of learning this book although I will do that sometimes.
- My edits to *schemewiki* is shown with nickname LisScheSic
```
----
<<<LisScheSic
...
>>>
```
# reading order recommendation with other books
- better read *pure* "Computer Architecture" (So not csapp) before SICP if having learnt other programming languages like C.
  Also read maths before SICP although not needed to be as deep as mcs.pdf.
  - maths will help understand something like 
    1. Figure 1.5
# book reading order
- The reading order:
  book with footnotes -> em -> exercise -> check "to reread after reading later chapters" and update this section in this doc *after reading each section*.
## em tracking when reading the book (Read before doing the related exercises)
- up to exercise 1.40 finished
## to reread after reading later chapters (strikethrough to mark already read)
tracked up to section 1.3 (included) by searching "chapter" and "section".
### 1.2
- ~~> You may wonder why anyone would care about raising numbers to the 1000th power. See Section 1.2.6.~~
### 1.3
- ~~chapter 1 footnote 12~~
  > to create procedures without naming them, and to give names to procedures that have already been created. We will see how to do this in Section 1.3.2.
  ~~footnote 21~~
  > In Section 1.3.4 we will see how to implement Newton’s method in general
- ~~> Notice that we have used *block structure (Section 1.1.8) to embed* the definitions of pi-next and pi-term within pi-sum, since these procedures are unlikely to be useful for any other purpose. We will see how to *get rid of them altogether* in Section 1.3.2.~~
### 2
- > In Chapter 2, when we investigate how to implement rational-number arithmetic, we will need to be able to compute s in order to reduce rational numbers to lowest terms.
- chapter 1 footnote 23.
- > We will return to these ideas in Section 2.2.3 when we show how to use sequences as interfaces
- > We’ll see examples of this aer we introduce data structures in Chapter 2.
### 3
- chapter 1 footnote 9, 16(also with *Chapter 4*), 27, 31
- > As we shall see in Chapter 3, the general notion of the environment
- 
  > We will discuss this more fully in Chapter 3 and *Chapter 4* when we examine the implementation of an interpreter in detail.
  > we will investigate some of its implications in Chapter 3 and *Chapter 4*
- > In particular, when we address in Chapter 3 the use of procedures with “mutable data,”
- > We’ll see how to use this as the basis for some fancy numerical tricks in Section 3.5.3.
### 4
- chapter 1 footnote 20
- > We will return to this issue in section 4.1.6, after we learn more about evaluation.
- > *requires reserving storage for a procedure’s free variables* even while the procedure is *not executing*. In the Scheme implementation we will study in Section 4.1, these variables are stored in the procedure’s environment.
### 5
- > culminat-ing with a complete implementation of an interpreter and com-piler in Chapter 5
- > When we discuss the implementation of procedures on register machines in Chap-ter 5
- > e imple- mentation of Scheme we shall consider in Chapter 5 does not share this defect.
# miscs
## blogspot comments left
- https://billthelizard.blogspot.com/2010/02/sicp-exercise-126-explicit.html?showComment=1719034722891#c6043924970819337247
# projects recommended by [course_note] to be done.
> Examples include an event-driven object-oriented simulation game, a conversational program that uses rules and pattern matching, symbolic algebra of polynomials and rational functions, interpreters for various languages, and a compiler with register optimization.
I skipped [Problem Sets](https://github.com/abrantesasf/sicp-abrantes-study-guide?tab=readme-ov-file), Exam, homework and Quizzes because IMHO those numerous exercises in the book is enough and most of courses pay more attention for projects when grading. Also 
- see [this](https://github.com/junqi-xie-learning/SICP-Projects?tab=readme-ov-file) (Here [one fork](https://github.com/junqi-xie-learning/SICP-Projects/forks) may be itself)
- I will only does 6.5151 skipping
  1. [sample projects](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/psets/index.html)
  2. 6.037 IAP
  3. 6.001 fall 2007
- TODO add the corresponding solutions for ~~the new [IAP](https://elo.mit.edu/iap/) [course 6.037](https://web.mit.edu/6.001/6.037/)~~ the 
# ~~6.001,037~~ courses (6.9550 Structure and Interpretation of Computer Programs newer without one website) (better read [6.945](http://computationalculture.net/a-matter-of-interpretation-a-review-of-structure-and-interpretation-of-computer-programs-javascript-edition/) whose [project uses sicp as the reference][AI_preq_sicp])
[6.001 fall 2007](https://web.archive.org/web/20160306110531/http://sicp.csail.mit.edu/Fall-2007/) which seems to be the last 6.001 course based on sicp as [this][mit_End_of_an_Era_comment] and 6.037 reference imply. (But 6.037 uses 6.001 spring 2007 ~~which~~ ~~may be preferable~~ because fall 2007 lecture notes aren't public)
## 6.001 spring 2007
Also see [this TA's site](https://people.csail.mit.edu/dalleyg/6.001/SP2007/) besides sicp.csail.mit.edu.
- > You can use the lecture based "text book" by going to the tutor
  I can't access tutor since I am not one MIT student.
- TODO see Some minor "bugs" in Project 4
- trivially I can't use [6.001 Lab – 34-501](https://groups.csail.mit.edu/mac/classes/6.001/FT98/lab-use.html), [outer door combination 94210, inner door combination 04862*](https://people.csail.mit.edu/dalleyg/6.001/SP2007/solutions01.pdf)
### lecture
- lecture corresponding chapter see 6.037 description.
- > These online lectures will generally cover the same material, but are *NOT guaranteed to be identical to the material covered in the live* lectures, and in some cases there may *not be a corresponding online version of the live* lecture.
- As [this](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/syllabus.html) shows, both book and lectures have contents that the other doesn't have. So we need to read them all.
### [comparison](https://stackoverflow.com/a/10251655/21294350) between MIT Scheme and DrScheme
### [recitation](https://people.csail.mit.edu/dalleyg/6.001/SP2007/) (not include the 1st recitation by Eric Grimson)
## [6.001 fall 2007](https://web.archive.org/web/20160306110531/http://sicp.csail.mit.edu/Fall-2007/)
### The following are mainly from https://web.archive.org/web/20160415073756/http://sicp.csail.mit.edu/Fall-2007/generalinfo_ft07.htm where "(*)" means it needs to be done.
https://web.archive.org/web/20070501000000*/http://sicp.csail.mit.edu/SchemeImplementations/index.html is not archived.
https://web.archive.org/web/20160629180214/http://sicp.csail.mit.edu/Fall-2007/SchemeImplementations/ is skipped since I don't use DrScheme.
#### lecture (*)
- where is link in [calendar](https://web.archive.org/web/20080908062550/http://sicp.csail.mit.edu/Fall-2007/calendar.txt)?
- partial lecture is [not archived](https://web.archive.org/web/20080908062839/http://sicp.csail.mit.edu/Fall-2007/lectures/)
- [This](https://github.com/abrantesasf/sicp-abrantes-study-guide?tab=readme-ov-file) only has [2005 "lecture notes"](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/pages/lecture-notes/), [96~98 notes](https://groups.csail.mit.edu/mac/classes/6.001/).
It seems to only have video lectures
> we have engaged in a major educational experiment in which the lectures were replaced with online lectures, to which students were *expected to listen*, either in the 6.001 lab, or on their own computer. ... but that material will *not be identical to the live* lectures.
#### recitations (*)
~~I~~ ~~don't have time to find that difference and also the lecture is old.~~ ~~will only do the~~ [recitations](https://people.csail.mit.edu/jastr/6001/fall07/) which is based on the video lecture.
Better read this if possible because this course is [taught by Gerald Jay Sussman](https://web.archive.org/web/20160415061035/http://sicp.csail.mit.edu/Fall-2007/staff.txt).
> Lectures are the primary vehicle for introducing and motivating new material, some of which is *not in the book*. It is essential that you *listen to the lectures* (whether live – which we prefer – or online), as the *recitations will assume you have already heard the material*, and will *build upon it*. ... Recitations *expand* upon the material currently being introduced in lecture, as well as introducing supplementary material that is *not directly covered in lecture*. ... your attendance at recitation is *essential to good performance* in this class.
#### problem set
I can't find by "6.001 fall 2007 Problem set site:mit.edu" which may be implied by
> Problem sets are released, typically on a weekly basis, onto the 6.001 *online tutor* system
#### tutorial
*skipped* due to
> to obtain *individual help*, to *review homework* assignments, and to have your *progress in the subject* checked
#### Assignments (i.e. [project](https://web.archive.org/web/20160415060551/http://sicp.csail.mit.edu/Fall-2007/projects/index.html)/~~Problem set~~)
> *failing to prepare ahead* for programming assignments generally ensures that the assignments will *take much longer* than necessary
#### collaboration (this is similar to one description I read before)
> For example, your partner has a bug on one part, and you are able to point out where the bug is and how to fix it.
inappropriate
> this is inappropriate collaboration because you were *not both involved in all aspects* of the work
#### Workload
> In addition, please be aware that prolonged computer usage combined with *poor posture or improper typing habits* can result in conditions such as *repetitive strain injury*.
#### bible (See the bold text)
#### grades
- homework
  > This applies to the weekly problem sets and to the *programming projects*.
  tutorials (skipped due to the following)
  > You may be asked to explain or to *expand upon your written homework solutions* in order to demonstrate your mastery of the material.
#### tutor
They are for tutorial's.
> If you are unable to attend a tutorial, you should contact your tutor in advance to make alternate arrangements for that week.

To join this it seems that we *must be one mit student* and [request a form (this is from the chemistry department)](https://chemistry.mit.edu/academic-programs/undergraduate-programs/tutoring/). This is also implied in spring 2007 6.001 lec01 p2.
### Complete Announcements
- not archived
  > GROWL! For those of you who did not show up in lecture on Tuesday, 2 October 2007, the essential handout you missed is here.
  > Code for the lecture given on Tuesday, 2 October 2007, has been placed here
  > GROWL! For those of you who did not show up in lecture on Tuesday, 6 November 2007, the essential handout you missed is here.
## 6.037 (notice [IAP may be not reliable](https://www.wisdomandwonder.com/link/2110/why-mit-switched-from-scheme-to-python#comment-365) and the instructor website [seems to not exist](https://web.archive.org/web/20120121084033/http://web.mit.edu/alexmv) different from [Gerald Jay Sussman](https://groups.csail.mit.edu/mac/users/gjs/gjs.html))
TODO who is the instructor Mike Phillips, is [him](https://en.wikipedia.org/wiki/Mike_Phillips_(speech_recognition))?
- See R5RS although sicp books uses R4RS as the reference.
  The newest is [R7RS](https://standards.scheme.org/official/r7rs.pdf) from [this](https://standards.scheme.org/) although racket seems to [not support](https://web.archive.org/web/20231208093804/http://community.schemewiki.org/?scheme-faq-standards#implementations) and has [one unofficial implementation](https://github.com/lexi-lambda/racket-r7rs)
  - R7RS [official](https://r7rs.org/) [errata](https://github.com/johnwcowan/r7rs-work/blob/master/R7RSSmallErrata.md) / [this](https://small.r7rs.org/wiki/R7RSSmallErrata/)
  - IEEE is [old](https://standards.scheme.org/formal/) also [see](https://conservatory.scheme.org/schemers/Documents/Standards/)
    > In colloquial use, “Scheme standard” usually refers to the latter.
  - scheme [doc](https://docs.scheme.org/) 
    - [cookbook](https://cookbook.scheme.org/)
    - [man](https://man.scheme.org/)
  - If using Racket, then [R5RS may be better](https://stackoverflow.com/a/3358638)
### what to do
- From 
  > 6 units of P/D/F credit are available; *only the projects* are graded.
  only "projects" need to be done after reading the lectures.
  But as the above says, I will skip that.
### comparison
- > which Spring 2007 6.001 lectures we've drawn the material from, in case you *want to delve deeper, get a second opinion*, read ahead, etc.
  > we are mostly *tracking the 6.001 lectures*
  > Since this course is a *heavily condensed* version of 6.001
- newer 6.037 uses Racket but [6.001 uses DrScheme](https://web.archive.org/web/20161201164940/http://sicp.csail.mit.edu/Spring-2007/dont_panic_ft06.html#SEC1). [See](https://stackoverflow.com/questions/13003850/little-schemer-and-racket)
### [DON'T PANIC](https://web.archive.org/web/20161201164940/http://sicp.csail.mit.edu/Spring-2007/dont_panic_ft06.html#SEC6)
- > the basic things that occur when you use the computer to write and evaluate code written in Scheme.
  - Flow of Control (trivial without saying much about more basic things like assembly)
    window manager -> the application (DrScheme window: one text editor 1. with "definitions window" and "interaction window" 2. can "Save Interactions as Text" 3. clicking on the Run tab similar to *python*) -> 
    > each subprogram is typically a definition
- Skip "Editing Your Code"
- TODO
  > Did I remember to evaluate all the changes that I made?
  > It's a good idea to *comment the transcript* after each problem, while the details are still in your mind.
  > How Can I Reach a *"Steady State?"*
  Debugger
- Debugging
  - > Only experience can help you become a master debugger. However, good discipline in trying to debug code can be very valuable experience.
    > Another handy tool provided by DrScheme is a syntax checker.
  - This should *not be used arbitrarily* because that will cause mess by my history experience.
    > If the debugger doesn't give you the needed information, sometimes it is useful to put a *display* or display expression into your code to gather information.
  - > It is often *easier to avoid bugs* than to find them so use a *clear* design *instead of clever or tricky* code
# course besides 6.001,037 in mit
- teachyourselfcs recommends [cs61a 2011](https://teachyourselfcs.com/#programming) which is [the last course](https://www.reddit.com/r/berkeley/comments/hl9rxt/comment/fwxonlz/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) to teach with scheme (See [this](https://github.com/theurere/berkeley_cs61a_spring-2011_archive/tree/master) for all resources [unavailable directly](https://web.archive.org/web/20110306121705/http://wla.berkeley.edu/~cs61a/sp11/lectures/) from university)
  See also [CS61AS](https://www.reddit.com/r/berkeley/comments/hl9rxt/comment/fwxpxo4/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) [mainly based on labs](https://www.reddit.com/r/berkeley/comments/38my8j/comment/cry702u/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) which is also said in its page
  - [comparison said by Brian Harvey](https://web.archive.org/web/20160304013558/https://www.cs.berkeley.edu/~bh/61a.html) from [this](https://www.reddit.com/r/berkeley/comments/38my8j/differences_between_cs_61a_and_cs_61as/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
    > Nevertheless, I *prefer* my own proposal for how to preserve 61A after my retirement: a self-paced version, CS 61AS, using SICP.
    > But also, I wish *I'd invented the self-paced structure* of the course years ago, before the issue of changing 61A came up. We've always had a pretty *high 61A dropout rate* because students can't keep up. It turns out, from our 61AS experience, that many of those students are perfectly capable of learning the ideas *if they're given more time*
    - > If you take the extra 5th unit, it will be called CS 98. (Despite what Brian wrote, the "H61AS" course description never actually happened.)
      may [mean (crawled by google)](https://inst.eecs.berkeley.edu/~cs61as/su12/)
      > Credit for Unit 5 will be assigned through a CS 98 course
      [CS 98](https://www2.eecs.berkeley.edu/Courses/CS98/)
    - maybe "problems" mean "high 61A dropout rate"
      > There is a plan afoot to *eliminate some of these problems* by recasting 61AS as a two-semester course
    - course design
      > Their solution was giving a unit of 61A credit for Unit 0, so students could take either Units 0-3 or Units 1-4.
      So we decide
      > for a constant four units (namely, Chapters 1-4 of SICP) ... Unit 0 will be offered as a separate one-unit CS 3S.
    - TODO
      I didn't find corresponding chapter description in [schedule](https://docs.google.com/spreadsheets/d/11If2HTqhRgMOAwqs4dWVV4ceRDJlj3orRnMkYJmMBBc/edit?pref=2&pli=1#gid=0)
      > And I can't give anyone a fifth unit of 61AS, even an optional one, for Chapter 5.
    - OP [decides to choose CS61A](https://www.reddit.com/r/berkeley/comments/38my8j/comment/crzsn72/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) because
      > My concern was not that CS61A going fast but slow. If it's going fast enough, I don't think there is much need for taking 61AS.
      learn both
      > I think one option I'm considering now is to self-study SICP in summer and take CS61A in fall.
      - TODO
        DeNero doesn't teach these 2 courses.
        > Also there is DeNero factor for 61A, I know.
## 2011 [hw, project etc. solution](https://github.com/zackads/sicp/tree/main)
~~TODO ""CS61AS" lab solution github" seems to not have CS61AS solutions. I will try that.~~
[video with Transcript to help search](https://www.youtube.com/watch?v=JAFUtlTrTHA&list=PL-4wJVBe4rQVeITP7acgaX86ukMKtOS3C)
A&S means "Abelson & Sussman" book.
interestingly inst.eecs.berkeley.edu [doesn't need one account before](https://web.archive.org/web/20120120151042/https://inst.eecs.berkeley.edu/~cs61a/su11/) and can be indexed by google.
- [cs61a 2011](http://wla.berkeley.edu/~cs61a/sp11/)
  [useful](http://wla.berkeley.edu/~cs61a/reader/vol2.html)
  - Weiner Lecture Archives seems to [*only* contain videos](https://web.archive.org/web/20120104033822/http://wla.berkeley.edu/main.php?course=cs61a) without others.
  - solutions [aren *unavailable*](https://web.archive.org/web/20111001000000*/https://inst.eecs.berkeley.edu/~cs61a/sp11/solutions)
    - maybe [this](http://wla.berkeley.edu/~cs61a/su11/solutions/) from https://github.com/fgalassi/cs61a-sp11?tab=readme-ov-file
  - https://web.archive.org/web/20110306121705/http://wla.berkeley.edu/~cs61a/sp11/lectures doesn't contain subdir's.
  - Simply Scheme by "Brian Harvey and Matthew Wright" online is like [the prerequisite of sicp](https://people.eecs.berkeley.edu/~bh/ssch26/preview.html) although as mit course says it is *not necessary*.
    > The *next step* is to read Structure and Interpretation of Computer Programs
  - Discussion group is piazzza which only university students can access.
  - STk seems to be one derivative of Scheme which can be ignored.
- [Course Reader, Volume 2](http://wla.berkeley.edu/~cs61a/reader/vol2.html)
  - [online lectures](https://web.archive.org/web/20120104011702/http://wla.berkeley.edu/main.php?course=cs61a) only have videos
- See [lecture notes](http://wla.berkeley.edu/~cs61a/reader/notes.pdf) for project schedule time and corresponding book Section.
- [readers](https://me.berkeley.edu/readers/)
- [OBSOLETE Homework, projects, lab](http://wla.berkeley.edu/~cs61a/reader/vol1.html)
- Course information (I only read bold text and the first sentence in each paragraph to get the main idea.)
  - recommends "You should try to complete the *reading assignment* for each week *before the lecture*.".
    - Although for mit OCW, it may [be not that case](https://qr.ae/psxpwo) written by one MIT student.
      > I will rarely read the textbook unless some combination of the following is true: (1) I am very confused or lack the requisite background, (2) I am specifically told to do so by the professor, (3) the textbook is *highly recommended* by people I know who *took the class* before, (4) I have *time* on my hands.
      > When I’m not taking the corresponding class in person, I take a similar approach to reading the book, but *only after I’ve watched the lectures and read through the notes*. ... I’d resort to notes from *other professors* (sometimes not from MIT) before I’ll read the book.
      for exam
      > , reading the textbook first would *help immensely*, but it’s *not as efficient* because I’ll learn a lot more about *what the professor thinks is important* by reading/watching material directly produced by him or her.
    - It [depends on the student habits](https://www.reddit.com/r/mit/comments/11d9ap0/comment/ja7d7a5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).
      > If a class requires readings before the lecture, it's usually *redundant* to the lecture and annoying (khm 6.031 khm)
      > I have a friend who enjoys reading textbooks at the end of the day to better understand and *digest the material from lectures*. Most of my friends and I do readings (mostly class notes *because usually there is no textbook*) while doing *psets/labs* if there are concepts we forgot/didn't understand/need a deeper understanding of for the assignment.
  - help
    > Your *first and most important* resource for help in learning the material in this course is your *fellow students* ... You are responsible for helping each other learn.
    self-study in campus
    > Instead, come see a faculty member to discuss *sponsorship of a non-class account* for independent study
  - Homework and Programming Assignments
    > The purpose of the homework is for you to learn the course, not to prove that you already know it
  - https://web.archive.org/web/20080514204601/http://www.swiss.ai.mit.edu/projects/scheme/index.html -> https://groups.csail.mit.edu/mac/projects/scheme/
    Etc. doesn't have much valuable.
    Answers to frequently asked questions (last updated in 1997). is skipped.
    Programming Language Research is skipped due to it is too detailed.
  - book
    > We have listed an optional text for the course, Simply Scheme, by Harvey and Wright. It *really is optional*! Don’t just buy it because you see it on the shelf.
  - think better than writing mere notes.
    > What this means is that you should be able to *devote your effort during lecture to thinking*, rather than to frantic scribbling.
### TODO
- Course information handout
  - > Unlike the homework and projects, the *tests* in this course (except for the parts specifically designated as group parts) must be your own, individual work
- why bh links to [Marxism](https://web.archive.org/web/20170225101107/https://www.anu.edu.au/polsci/marx/marx.html)??????
### comparison between scheme and python
- [1](https://news.ycombinator.com/item?id=9844181)
  >  You almost certainly *missed out on things* that you could very well *never see again*, or even know the existence of (at least for a very long time)
  kw: metaprogramming, macros, 
  > This is something you can't even dream of doing in most (all?) languages that *aren't dialects of LISP*.
  - [2](https://news.ycombinator.com/item?id=9843053)
    > The first 1/3 of CS61A in scheme had *no mutation*. That is almost impossible in Python to do, and is not the way the language is used in industry
    Python is to help the majority of struggling students
    > but perhaps fail to grasp some of the more complex concepts ... 80% of the material hasn't changed but you've gained the above benefits
    > If you understood the intricacies of what *was* taught in CS61A, you will find it very easy to *generalize* those concepts to *new languages* - and new concepts.
So I skip [this python lesson 6.100](https://introcomp.mit.edu/spring24/information)
### lab
recommended since the course general information shows (more detailed see 1.md)
> Laboratory exercises are short, relatively simple exercises designed to *introduce a new topic*.

[lab solutions](https://people.eecs.berkeley.edu/~bh/61a-pages/)
- Also [see](https://github.com/nirvanarsc/CS-61A/blob/master/mt1/mt1.scm) (TODO mt -> meeting?)
### update [Course Reader vol 1](https://people.eecs.berkeley.edu/~bh/61a-pages/)
### what to learn
- [lecture and lab](https://www.reddit.com/r/learnprogramming/comments/1daa41z/comment/l7nwqbp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
  since we drop the others
  1. > all book exercises which cover the homework
  2. > I prefer doing the project assignments from MIT 6.5151
  3. > it is a bit overkill to do all these sample exams
  - [notes](https://people.eecs.berkeley.edu/~bh/61a-pages/Volume2/notes.pdf) (originally I accessed it from [this](http://wla.berkeley.edu/~cs61a/reader/notes.pdf) where both have the same page count) and [lab](https://people.eecs.berkeley.edu/~bh/61a-pages/Volume1/labs.pdf)
## cs61as
The latest should be CS "61AS" spring 2016 since 'CS "61AS" fall 2016' has nothing.
I only check labs without checking Homework, Quizzes and Retakes
- Syllabus
  - uses Racket
  - > Lessons also link to external readings drawn from *SICP and old CS 61A lecture notes*'
  - "Units" shows the corresponding book chapters.
- Suggested Schedule & All Deadlines don't give project corresponding chapters
  So by Syllabus and textbook, maybe project x corresponds to chapter x.
- FAQ doesn't have much about what to be learnt.
- the following needs university student account
  - Discussion Worksheets and Solutions
- Webcasts fails now.
- Legacy Resources -> Lecture Notes may point to cs61a
- [Environment Diagram Drawer](https://cs61a.org/assets/pdfs/reverse-ed.pdf)
### reading
- > Lessons also link to external readings drawn from SICP and old CS 61A lecture notes. It is highly recommended that you complete *these readings before starting the lesson* material.
# How to learn
## project
- "lab exercises, computer examples" may [be important](https://academia.stackexchange.com/a/151857)
## book vs lecture
- better [not drop the textbook with only lectures left](https://www.physicsforums.com/threads/which-is-more-effective-for-learning-textbook-or-lecture-notes.467145/post-3105007) after *considering time*
  Also [see](https://www.physicsforums.com/threads/which-is-more-effective-for-learning-textbook-or-lecture-notes.467145/post-3105014)
  > The only thing I feel professors are good for is *answering questions* which are *not fully answered* in the textbook.
  - Also see [this](https://www.reddit.com/r/math/comments/13jq1b8/comment/jkgkcee/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) which means *book & exercises* is better with its following comments. (Also see [this](https://www.reddit.com/r/math/comments/13jq1b8/comment/jkgozm5/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) which recommends the book and Roneitis's comment)
- [~~This lecture~~](https://news.ycombinator.com/item?id=19887732) means live lectures
## video
- what video [actually needs to do](https://academia.stackexchange.com/a/52758)
  > The advantage of the human teacher is that I *can ask questions*, but of course a video teacher cannot answer. There are cases, of course, where a video is superior to a printed book: a video can *show action* that a book can only describe or perhaps show still photos. So if you want to learn how to *perform some physical action*, like how to play golf or replace a transmission filter or whatever, a video might be able to show you in ways that *a book could not.*
- video lectures should [not be dependent more than the book](https://qr.ae/psJ39d). 
  Also [see](https://www.reddit.com/r/learnprogramming/comments/8tn6pv/comment/e18s63p/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
  - [this](https://qr.ae/psJBAi) and [this](https://www.reddit.com/r/PhysicsStudents/comments/oll49b/comment/h5g0fel/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) says video is *only as one companion* but not the main part.
## summary
- [detailed][academia_se_tips]
  1. not drop one part artificially.
  2. better read the *lecture before* the book to get the *main idea*
  3. spend "~90% of their time working problems". (Although ~90 may be too high for actual course learning.)
- choose [the favorable method](https://mitili.mit.edu/news/compared-reading-how-much-does-video-improve-learning-outcomes) to learn
  > Likewise, those who *preferred to read and did read* scored nearly 10 percent *higher* on the post assessment than participants in the video group who would have preferred to read.
# Emacs
- [reference card](https://www.gnu.org/software/emacs/refcards/pdf/refcard.pdf)
- [brief intro to run scheme](https://languageagnostic.blogspot.com/2011/05/mit-scheme-in-emacs.html?m=1) from [this](https://www.reddit.com/r/scheme/comments/grnz6o/comment/fs248nv/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
# (misc)
## How to write emails to TA, etc
- see [comics](https://advising.yalecollege.yale.edu/how-write-email-your-instructor) or [example](https://www.purdue.edu/advisors/students/professor.php)
  - 1
    - a clear subject line
    - *Do your part in solving* what you need to solve.
    - Be aware of concerns about entitlement. (i.e. respectful)
    - *shaping* your words in light of *whom you are writing to* and why.
      > share information regarding an event the professor *might want to know* about or pass on an article from your news feed that is *relevant to the course*
  - 2
    - correct grammar and spelling
- [more general](https://sparkmailapp.com/formal-email-template)
- [should I add period at the end in the brackets](https://proofed.com/writing-tips/punctuate-brackets/#:~:text=However%2C%20we%20have%20a%20few,case%20the%20period%20goes%20inside.)
  > I ate the whole cake. (And now I am full.)
## grading curve
- https://www.bestcolleges.com/blog/curved-grading/#:~:text=What%20Is%20Grading%20on%20a%20Curve%3F,A%20grades%20and%20failing%20grades.
  > they can grade on a curve. That means *modifying each student's grade* to *raise the average*.
# MIT-scheme miscs
- [exit message meaning](https://github.com/search?q=repo%3Abarak%2Fmit-scheme%20term_halt_messages&type=code) https://github.com/barak/mit-scheme/blob/56e1a12439628e4424b8c3ce2a3118449db509ab/src/microcode/term.c#L111C5-L111C30
# html book searching tips
- select by the specific emphasized text
  [XPath](https://scrapfly.io/blog/how-to-select-elements-by-text-in-xpath/) ([no corresponding CSS selector](https://stackoverflow.com/a/4561376/21294350))
- following-sibling
  [XPath -> selector](https://devhints.io/xpath#using-axes)
# scheme style
- [1](https://web.archive.org/web/20240117063034/http://community.schemewiki.org/?scheme-style)
  - preface says about the indentation.
  - Rule 1: not "Don't put closing (or opening) parens on a line of their own", i.e. one line with only one paren.
    > Notice how the closing parens are all on a line of their own, *indented so to mark* where the expression will continue. Remember, it's *an exception - use this rarely*.
  - For the rest I only read their titles.
- [naming](http://community.schemewiki.org/?variable-naming-convention)
  - TODO
    *Name
  - From RnRS is same as [1.3.5 in R7RS](https://standards.scheme.org/official/r7rs.pdf)
- [comment convention](https://web.archive.org/web/20220526005605/http://community.schemewiki.org/?comment-style)
- I skipped "Scheme Tips from Dartmouth" since format is not that important but needs to be consistent when cooperation.

---

# Foreword
- [predicate calculus](https://github.com/sci-42ver/Discrete_Mathematics_and_Algorithm/blob/f515bc30a45a6a97c8a92641296a717d980441a0/Discrete_Mathematics_and_Its_Applications/mcs.md?plain=1#L764)
- > composed of . . .
  i.e. again "physical switching element ..." because MOS is one type of switching element.
- > It would be difficult to find two languages that are *the communicating coin of two more different cultures* than those gathered around these two languages.
  From [this](https://ell.stackexchange.com/a/133661), "those gathered around" (i.e. "the communicating coin" of Lisp and Pascal) may mean their shared components in Algol60.
- > e discretionary exportable functionality entrusted to the individual Lisp programmer is more than an order of magnitude greater than that to be found within Pascal enterprises
  i.e. Lisp can [generate languages](https://www.reddit.com/r/learnprogramming/comments/vluzqf/comment/idxrcoe/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
## TODO (Foreword may need some background knowledge)
- read after finishing the book
  > Lisp changes. ...
  and other green underlined words
# Preface to the First Edition (I read this first)
- > not just a way of geing a computer to perform oper-ations but rather that it is a novel formal medium for expressing ideas about methodology
  it means not ... but rather ... .
- > the foundations of computing,
  at least ["data structures and formalisms"](https://cics.unt.edu/node/41)
- > have very few ways of forming compound expressions,
  by multiplication principle, the component number is small.
- > All of the formal properties can be covered in an hour, like the rules of chess.
  This is also said in [ucb_sicp_review] (Also see Discrete_Mathematics_and_Algorithm repo).
## TODO
- check "Our goal ..." after reading the book.
- > we can use higher-order functions to capture common paerns of usage, ...
- > the relationship of Church's lambda calculus to the structure of programming languages
  [1](https://news.ycombinator.com/item?id=40056166) [2](https://users.cs.utah.edu/~mflatt/past-courses/cs7520/public_html/s06/notes.pdf)
# Preface to the Second Edition
- http://mitpress.mit.edu/sicp is [invalid now](https://web.archive.org/web/20230916001533/http://mitpress.mit.edu/9780262510875/structure-and-interpretation-of-computer-programs/#tab-5)
# [A note on our course at MIT][course_note]
- > to separate specification from implementation
  similar to [ucb_sicp_review]
  > a diversity of major programming paradigms: data abstraction, rule-based systems, object-oriented programming, functional programming, logic programming, and constructing embedded interpreters.
  > Students are encouraged to regard themselves as *language designers and implementors* rather than only language users.
  > 6.001 differs from typical introductory computer science subjects in using Scheme (a block-structured dialect of Lisp) *rather than Pascal* as its programming vehicle.
  > they consider *top-down hierarchical design*, so often emphasized as a central theme in computer programming subjects, to be a *minor and relatively simplistic* strategy
  > introducing two different techniques for maintaining modularity: object-oriented programming with encapsulated local state; and functional programming with *delayed evaluation*.
  > is recommended for other majors where *computation pays a major role* ... taken by over 500 students each year -- *half to two-thirds* of all MIT undergraduates ... more than three-quarters have had *previous programming experience*, although hardly any at the level of sophistication of 6.001.
  > MIT students regard 6.001 as an *extremely challenging*, but highly successful subject
  > There are also regular *weekly tutorials*, where students meet in groups of three with a graduate TA to *review* homework and other course material.
- TODO
  > shifting modes of linguistic description
  > *Beyond that, there is a central concern* with the technology of implementing languages and linguistic support for programming paradigms.
  > It discusses substitution semantics, the evolution of processes, orders of growth, and the use of higher-order procedures. ... symbol manipulation, including data abstraction and generic operations.
  > It presents a full interpreter for Scheme, and, for comparison, an interpreter for a logic programming language similar to pure Prolog.
- [RTL](https://web.archive.org/web/20240414035412/https://ars.els-cdn.com/content/image/3-s2.0-B9780750689748000053-gr20.jpg) -> [Register Transfer](https://www.geeksforgeeks.org/register-transfer-language-rtl/#)
  It is one ["design abstraction" method](https://en.wikipedia.org/wiki/Register-transfer_level)
- So we need to do [*projects* (See Grades)](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/pages/syllabus/)
  > but the *crucial learning* done by students is through *substantial weekly programming assignments*. These focus on reading and modifying significant systems, rather than writing small programs from scratch.
- [new book site](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/index.html) same as the [old one](https://web.archive.org/web/20160306140516/https://mitpress.mit.edu/sicp/) from [this](https://web.archive.org/web/20160303050117/http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/) where "excerpts from the book" may mean "Full text!"
  > This includes excerpts from the book, a collection of sample assignments, and information on where to obtain implementations of Scheme.
# Acknowledgments
- > Our subject is a *clear intellectual descendant* of ``6.231,'' a wonderful subject on programming linguistics and the lambda calculus taught at MIT in the *late 1960s* by Jack Wozencraft and Arthur Evans, Jr.
  6.231 uses [one different language](https://www.cl.cam.ac.uk/~mr10/PAL.html).
  [new Lambda Calculus course](https://ocw.mit.edu/courses/6-820-fundamentals-of-program-analysis-fall-2015/pages/syllabus/)
  1960s seems to be [too old to be archived](https://ocw.mit.edu/about/) (Also see [wikipedia](https://en.wikipedia.org/wiki/MIT_OpenCourseWare))
## [scheme official](https://www.scheme.org/) migrated from [Schemers.org](http://www.schemers.org/) (I seems to search R4RS and met this website)
- what is [newsgroup](https://www.wikihow.com/Access-Newsgroups) Also [see](https://comp.lang.scheme.narkive.com/)
- [faqs.org](http://www.faqs.org/faqs/by-newsgroup/comp/comp.lang.scheme.html)
- https://chat.scheme.org/ seems to be same as https://community.scheme.org/
- https://books.scheme.org/ doesn't give one order
  - Not use [commercial EdScheme](https://gustavus.edu/academics/departments/mathematics-computer-science-and-statistics/max/concabs/schemes/edscheme/win/) related with book Concrete Abstractions by Mike Eisenberg.
### [community.schemewiki](https://web.archive.org/web/20240228152042/http://community.schemewiki.org) (notice the following link may be not latest for the schemewiki link, they are just for reference.)
- [code](https://web.archive.org/web/20240228135155/http://community.schemewiki.org/?category-code)
- [learning scheme](https://web.archive.org/web/20230730151321/http://community.schemewiki.org/?category-learning-scheme) although sicp doesn't intend to teach that.
- [manual](https://web.archive.org/web/20230923095649/http://community.schemewiki.org/?category-manuals)
- [different faq's](https://web.archive.org/web/20220117101744/http://community.schemewiki.org/?category-scheme-faq)
  - scheme-faq-general
    - > *Development time and maintenance effort* are often much *more important than execution speed* and memory resources
      TODO
      > The design of Scheme makes it quite hard to perform certain common types of optimisations. For instance, one cannot normally inline calls to primitives (such as + and car) because Scheme allows the re-binding of their names to different functions
    - [debugger](https://web.archive.org/web/20231208093804/http://community.schemewiki.org/?scheme-faq-standards#debuggers)
      > it also imposes some limitations, e.g. the debugger *cannot catch runtime errors* and some tail-recursive calls may *become non-tail-recursive*. PSD is therefore *no substitute for a native debugger* but an extension for Schemes with no debugger at all.
  - TODO [scheme-faq-programming](https://web.archive.org/web/20230923102638/http://community.schemewiki.org/?scheme-faq-programming) and https://web.archive.org/web/20231122105715/http://community.schemewiki.org/?scheme-faq-misc
    also other scheme-faq-...
### https://conservatory.scheme.org/schemers/
- https://conservatory.scheme.org/schemers/Education/
  The TeachScheme! Project (now https://programbydesign.org/) is targeted for "middle-school, high-school and university levels"
- TODO 
  - check program
  - [Functional Programming FAQ](https://web.archive.org/web/20090524191417/http://www.cs.nott.ac.uk/~gmh//faq.html)
- old	[Schemers Inc. page](https://web.archive.org/web/20051229151833/http://www.schemers.com/)

---

# How Do I learn SICP
- I read
  - lectures (I skipped Recitation because they are only review with no new knowledge to teach) first as [academia_se_tips] point 2 shows.
    - 6.037 (not read "With slide transitions" which is for lecture ppt instead of self-study)
    - 6.001 2007
  - read the book
  - use video when unable to understand
- When learning OSTEP, I read almost the book word by word since there is not many formulae or programs in it. But when reviewing briefly what I have got from this learning method now, I found there is not much.
  So I will read SICP cover to cover by reading the 1st sentence for each paragraph and decide whether to read more about that paragraph by whether that paragraph matters and I can get the idea merely from the 1st sentence.
  But I will read footnote and quotes word by word since they may imply something important.
- For SICP book, I didn't revisit the book back for something like
  > who explained it in terms of the “message-passing” model of computation that we *shall discuss in Chapter 3*
# CS 61AS chapter 0
## 0.1
- https://web.archive.org/web/20150601000000*/http://start.cs61as.org/ doesn't work
- > Computer scientists are like engineers: we build cool stuff, and we solve problems.
  the links are interesting.
- > your browser has to determine which server to contact, ask that server to give it the webpage you're looking for, download the webpage, interpret the webpage, and display it on your screen.
  DNS -> communication -> network transfer -> interpreter -> GUI
- `(+)` just adds nothing -> 0.
- kw
  > This so-called "textbook" consists of 17 lessons, *most of which are based on the classic text* Structure and Interpretation of Computer Programs, which gives this course its name.
  programming languages
  > That's because in the grand scheme of things, *programming languages don't matter*. They only matter because, for any given problem, one language might let us solve the problem *in fewer lines* of code over another, or one language might let us solve the problem *more efficiently*, and so on.
  > As you learn more computer science, we'll *incrementally show you more of the language*.
  Interpreters
  > Interpreters: We go into how an interpreter works, and we'll even write our own. We'll also consider a few other interpreters and see *what they all have in common*.
  CS 61A
  > CS 61A is the sister course to CS 61AS. It is offered in the traditional *lecture-lab-discussion* format,
  > CS 61AS is a lab-centric class—there are no lectures. Students learn by working *through guided readings and participating in discussions*.
- [detailed comparison](https://docs.google.com/document/d/1htUkJJHXnXnDVMLq4avHsCbIAWFfki_hxuLumtYz6Os/edit)
  > In CS 61A, we are interested in teaching you about programming, *not about how to use one particular programming language*. ... Mastery of a particular programming language is a very useful *side effect* of studying these general techniques.
  Comparison of Courses
  > A bit of Python (build a Python interpreter)
  - What if I've never programmed before? -> Unit 0
  - Do I have to go to lab/discussion?
    > You are highly encouraged, but *not required to attend discussions*.
    > In CS 10 and CS 61AS, lab is the only place in order to *take quizzes*.
  - [L&S](https://guide.berkeley.edu/courses/l_s/) [Breadths](https://lsadvising.berkeley.edu/seven-course-breadth#:~:text=An%20exception%20to%20this%20limitation,wish%20for%20Seven%2DCourse%20Breadth.) may be targetted more at Letters
    > introducing them to *a multitude of perspectives and approaches to research and scholarship*.
  - Why does 61AS use Scheme/Racket when 61A uses Python?
    This is almost same as the preface about syntax.
    Also same as about "Python" as "The End of an Era" says.
    > It should be said that both 61A and 61AS staff consider Python and Scheme to be good programming languages to learn (hence they *show up in both* courses),
  - TODO 
    my facebook account is always banned due to the IP problem.
    "Berkeley Facebook group"
  - General Info of CS 61AS
    - > You learn by working through short readings and guided labs and participating in discussions
      "short readings and guided labs" is almost same as MIT 6.5151 (6.905).
    - > 61AS Uses SICP, which is The Best Computer Science Book. This is the book that the *61A lecture notes are based off of*.
      Here probably mean the new 61A using Python as indicated by the above "detailed comparison".
    - This is probably for [CS 61AS 2015](https://www.alicialuengo.com/Resume.pdf)
### Homework
- > Why is and a special form? Because it evaluates its arguments and stops as soon as it can, returning false as soon as any argument evaluates to false.
  ~~TODO can `cond` implement `and` correctly?~~
  Same reasons as `if` in Exercise 1.6 where applicative-order causes the evaluation order to be wrong.
  See summary in 0.2
  > quote is different from most other procedures in that it *does not evaluate its argument*. Functions that exhibit this type of behavior are special forms.
  And https://berkeley-cs61as.github.io/textbook/special-forms.html#sub2
- [`[,bt for context]`](https://github.com/racket/xrepl/issues/6#issuecomment-271360651)
- > Why did the Walrus cross the Serengeti?
  https://www.expertafrica.com/tanzania/info/serengeti-wildebeest-migration
  > They migrate throughout the year, constantly seeking fresh grazing and, it's now thought, better quality water.
- 0.1-Exercise 4 is same as book exercise 1.6.
- Recommended Readings is 
  CS61a 2011 notes and the book
- TODO
  - scheme require file diff load in `racket -t` vs `-f`.
- `sudo racket -tm grader.rkt -- hw0-1-tests.rkt hw0-1.rkt` to run all tests.
## 0.2
- > "the greatest single programming language ever designed" -- Alan Kay
  See https://qr.ae/psmZZR. At least "operators" differ.
  This also implies Scheme can define other lanugages.
- Readings are from "Simply Scheme: Introducing Computer Science".
- `'61AS` in newer Racket at least has the value.
- Use `(require (planet dyoo/simply-scheme))` to use `butlast`.
- See "The Empty Sentence" and "The Empty Word".
- [`.` usage](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC29)
  - Also see [`define`](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_7.html#IDX135)
    > the value of the definition is completely evaluated before being assigned to its variable.
    [same](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_7.html#SEC45) as [`set!`](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX77)
    > If <variable> is not bound, however, then the definition will bind <variable> to a new location before performing the assignment
    i.e. it will init while `set!` won't.
    - [letrec](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX93)
      > the <init>s are evaluated in the resulting environment (in *some unspecified order*)
      implies
      > it must be possible to evaluate each <expression> of every internal definition in a <body> *without assigning or referring to* the value of any <variable> *being defined*.
    - > An important property of procedure definitions is that the body of the procedure is not evaluated until the procedure is called.
      I didn't fine it in the R5RS doc.
      This is reasonable because the `body` may contain argument.
      ```scheme
      (define (foo sent word)
        (word sent word)) ; Here word will be local. If pass in `'a`, then it is not one procedure.
      ```
- TODO
  > The period and comma also have special meaning, so you cannot use those, either.
- https://berkeley-cs61as.github.io/textbook/special-forms.html#sub2
  - Test Your Understanding
    `(and #f (/ 1 0) #t)`
    `(or #t #f (/ 1 0))`
  - > *Simple code is smart code*, and will make complex programs much more readable and maneuverable.
## 0.3
- > One of its arguments must be a number that tracks the stage of computation for the current recursive call.
  this is not necessary always because we can [use *global* variables](https://stackoverflow.com/q/51682848/21294350).
- > Back in Lesson 0-2, we stated an important property of defining procedures, where the procedure body is not evaluated when it is definted. This is the technical reason why recursion can work.
  So when define `(factorial n)`, `(factorial (- n 1))` doesn't need to be valid.
  > Thus, define is a special form that does not evaluate its arguments and keeps the procedure body from being evaluated. The body is only evaluated when you call the procedure outside of the definition.
  i.e. "not evaluate"d when `define` but "evaluate"d when invoked.
- > Which of these expressions cause an error in Racket? Select all that apply.
  Notice
  https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC29
  > When the procedure is *later called* with some actual arguments, the environment in which the lambda expression was evaluated will be extended by binding the variables in the formal argument list to fresh locations, the corresponding *actual argument values will be stored* in those locations, and the expressions in *the body of the lambda expression will be evaluated sequentially* in the extended environment.
  https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#SEC31 (See the above `set!`)
  > <Expression> is *evaluated*, and the resulting value is stored in the location to which <variable> is bound.
- > Think about what happens if the word contains no vowels.
  The endless loop.
- > we have to decide whether or not to keep the first available element in the return value. When we do keep an element, we keep the element itself, not some function of the element.
  i.e. no need to call "some function of the element" recursively.
  IMHO here obviously we need to manipulate with "the element", so not "the element itself".
- Comparing "The "Accumulate" Pattern" with "The "Every" Pattern",
  the former has "a single result" while the latter will have a list like "a sentence".
- `(pigl wd)` doesn't iterate all elements although it follows "the accumulate pattern".
# CS 61A Unix_Shell_Programming
- `tr -d '.,;:"![]()' < summary` is enough.
- `tr ’[A-Z]’ ’[a-z]’ < oneword > lowcase` See `info tr`.
- [`[=e=]` (See macOS tr)](https://www.davekb.com/browse_computer_tips:linux_tr_equiv_chars:txt)
- Also see `info join` example
# CS 61A lab
Up to Week 3, they are much easier than the book exercises 
or more specifically they are easy after having done exercises.
## Week 1 part 1
- I won't check `emacs`.
- I [don't have 32-bit system](https://people.eecs.berkeley.edu/~bh/61a-pages/Scheme/source/linux.html), so I won't install stk
## Week 1 part 2
[sol](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week1)
- 3 is already done in Exercise 1.3.
  - > The way I like best, I think, is a little tricky:
    Here it just sort the 1st 2 items and then sort the latter 2 items.
    Then the 2 bigger are put at first.
  - > This hardly seems worth the effort, but the attempt to *split the problem into logical pieces* was well-motivated.
  - https://code.google.com/archive/p/jrm-code-project/wikis/ProgrammingArt.wiki
    > Consider this solution: (define (sum-square-largest x y z) (cond ((and (< x y) (< x z)) ;; x is smallest (+ (* y y) (* z z))) (else (sum-square-largest y z x))))
    i.e. filter the smallest number step by step.
    https://web.archive.org/web/20080723104814/http://programming.reddit.com/info/1nb8t/comments not with much valuable comments about "art".
## Week 2
[sol](https://people.eecs.berkeley.edu/~bh/61a-pages/Solutions/week2) with the different order from the lab pdf.
- `((lambda (x) (+ x 3) 7)` notice the bold text which implies the unpaired parentheses.
- [x] 2
  - sol
    - TODO
      meaning of "PL-SENT", ENDS-E.
- [x] 3
  - 0, procedure.
- [x] 4
  ```scheme
  (define f 2)
  ; f should be one procedure for `(f)`
  ; (f 3): one procedure taking one number as the argument
  ; ((f)): one procedure taking zero argument and return one procedure
  (define (f)
    (lambda () (lambda (x) (+ x 2))))
  (((f))3) ; 5
  ```
  - sol
    > Again, these definitions are *shorthand for lambda* expressions:
    - > As a super tricky solution, for hotshots only, try this:
      ~~endless loop~~
      Here `f` has no meaning at all.
    - kw:
      > you could use `(define (f . args) f)` as the answer to *all* of these problems!
- [x] 5
  `((t 1+) 0)` -> 3
  `((t (t 1+)) 0)` -> 3*3=9
  `(((t t) 1+) 0)` -> `(((lambda (x) (t (t (t x)))) 1+) 0)` -> `((t(t(t 1+))) 0)` $3^3$
  - sol
    - kw:
      > but what's important is the function, not the expression that produced the function
- [x] 6 trivial same as 5
- [x] 7
  ```scheme
  (define (make-tester x)
    (lambda (y)
      (equal? x y)))
  ((make-tester 'hal) 'hal)
  ((make-tester 'hal) 'cs61a)
  ```
## Week 3
- [x] 1 reverses the order of `(= kinds-of-coins 1)`... or `(first-denomination (- 6 kinds-of-coins))`
- [x] 2 should be almost ~~1:50.~~
  - sol
    > match *a small amount of money with a large coin* ... When the coins are tried in the book's order, by the time we are thinking about four cents, we have already *abandoned the idea of using nickels*
- [x] 3
- [ ] 
# chapter 1
Since I was to learn programming, so for paragraphs not intensively with programming knowledge I only read their first sentence.
## 6.037 ~~(dropped for future reading except this one already read)~~ (may read as one quick review after reading the book)
- [web.mit.edu/alexmv/6.037/](https://web.archive.org/web/20200113183359/http://web.mit.edu/alexmv/6.037/)
- [Graduate P/D/F](https://registrar.mit.edu/classes-grades-evaluations/grades/grading-policies/graduate-pdf-option) is *not one standard* option
- TODO
  - [TR](https://kb.mit.edu/confluence/display/glossary/TR) meaning in "TR, 7-9PM"
- Newton's method (i.e. approximation based on derivative) -> Heron's method [proof](https://math.stackexchange.com/a/1733394/1059606)
  notice here we can't use $f(x)=\sqrt{x}-\sqrt{2},x\mapsto x-\frac{\sqrt{x}-\sqrt{2}}{\frac{1}{2\sqrt{x}}}=2\sqrt{2x}-x$ where the mapped result contains $\sqrt{2}$ which is what ~~since~~ we want to calculate~~$\sqrt{2}$~~.
  - Also see chapter 1.3
    > When we first introduced the square-root procedure, in section 1.1.7, we mentioned that this was *a special case of Newton's method*.
    > For instance, to find the square root of x, we can use Newton's method to find a zero of the function y  y2 - x starting with an initial guess of 1.
- [shire album book series](https://www.somethingunderthebed.com/CURTAIN/SHIRE_ALBUM.html)
  - TODO does the author have one website (search by "Calculating Machines and Computers Geoffrey Tweedale page")?
- TODO what is silicon well, Higgs field?
- TTODO which means it must be understood for further study.
  - `#<procedure:+>`
- I installed mit-scheme using aur which is [updated](https://groups.csail.mit.edu/mac/users/gjs/6.945/dont-panic/#org1107e7f)
- > Why can’t "if" be implemented as a regular lambda procedure?
  because lambda is [*sequential*](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Lambda-Expressions.html)
  > the exprs in the body of the lambda expression are evaluated sequentially in it
  - `expr expr` in the above link may be no use. But `define` [may use that](https://stackoverflow.com/a/47166401/21294350).
  - I don't find "regular lambda" in [the video transcript](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/resources/1b-procedures-and-processes-substitution-model/)
  - Also see exercise 1.6 where even `cond` can't implement it *with the `define` syntactic sugar for `lambda`*.
- > How do we know it works?
  It only shows one big iteration step where 2 in `(lambda (a b) (/ (+ a b) 2)) 1.0 2` should be ` (/ x guess)`.
- > But, it only solves a smaller version of the problem
  may mean the false `(fact 0)`. p53 is same as Figure 1.3.
- > Better idea: count up, doing one multiplication at a time
  compared with "recursive algorithms", the latter only manipulates with the stack without doing the arithmetic.
- > output value
  may be "output*s* value".
- > express in tabular form
  See p57.
## 6.001 sp07
IMHO 6.037 is the condensed (as its main page says) of 6.001 lectures by removing many figures.
*Seriously* 6.037 drops "Proving that our code works" in lec 3 which is important although this will be learned in the future.
### 1
- TODO
  - > Could just store tons of “what is” information
- kw:
  - robustness and [flexibility](https://www.geeksforgeeks.org/flexibility-vs-security-in-system-design/) which may be probably said in COD.
- [higher order procedure](https://people.eecs.berkeley.edu/~bh/ssch8/higher.html#:~:text=A%20function%20that%20takes%20another,%E2%80%94a%20higher%2Dorder%20procedure.)
- > Use a language to describe processes
  See [this (I only read the context of "process")](https://cs.stackexchange.com/a/142870/161388)
  >  figure the most *important elements to formalize* and how they interact with each other
- > This creates a loop in our system, can create a complex thing, name it, treat it as primitive
  then one complex thing based on that new primitive ... primitive ...
### rec2 (naming follows 6.001 fall 2007)
- > Names may be made of any collection of characters that doesn’t start with a number.
  [See](https://www.scheme.com/tspl2d/intro.html)
  > Identifiers normally cannot start with any character that may start a number, i.e., a digit, plus sign ( + ), minus sign ( - ), or decimal point ( . ).
### 2
- Rumplestiltskin effect just means [naming](https://en.wikipedia.org/wiki/Rumpelstiltskin#Rumpelstiltskin_principle).
- > Next lecture, we will see a formal way of tracing evolution of evaluation process
  in lec 3 p4 it is not that formal but just listing all stages.
  induction is more formal.
### 3 Procedures, recursion
- > E.g. keep trying, but bring sandwiches and a cot
  This may mean it will take a long time.
  Also see [similar words with the different meaning (3 Hots & A Cot)](https://www.urbandictionary.com/define.php?term=3%20hots%20and%20a%20cot)
### rec3 recursion
1. [ ] count1 from n to 0 and count2 from 0 to n.
  - `0` is not displayed by `our-display`.
```bash
1 ]=> (count1 4)
4321
;Value: 0 # here is output by the last (= x 0) 0

1 ]=> (count2 4)    
1234
;Value: 4 # here is output by the last (our-display 4)
```
2. [x] is solved by the lec
3. [ ] use $\lim_{n\to \infty^+}(1+\frac{1}{n})^n$?
  Then $n=1e^{input}$ where `input=-100`, etc.
  - See [this QA](https://stackoverflow.com/q/78597962/21294350)
    We should better read the book first before the recitation since
    1. floating precision problem is said in exercise 1.7.
    2. Shawn's comment is implied in [one footnote](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-10.html#footnote_Temp_35).
1. [x] see code
2. [ ] I originally planned to use base case for `n=1,2`.
  The solution is more elegant to use implicitly the 0th number being 0 although in the actual series that doesn't exist.
1. [ ] See https://www.mathsisfun.com/numbers/golden-ratio.html. See the approximation formula said in mcs p1005.
## book reading
### 1.1
- > an integration of the motion of the Solar System
  [See](https://en.wikipedia.org/wiki/Stability_of_the_Solar_System)
- > A second advantage of prefix notation is that it extends in a straight-forward way to allow combinations to be nested
  i.e. enforced parentheses which has much less ambiguity.
- > paraphrasing Oscar Wilde
  [See](https://www.edge.org/response-detail/10765#:~:text=What%20is%20value%3F,and%20the%20value%20of%20nothing%22.)
- > operators are themselves compound expressions
  [See](https://stackoverflow.com/q/57091377/21294350)
- > Syntactic sugar causes cancer of the semicolon
  [See](https://stackoverflow.com/questions/547710/why-is-syntactic-sugar-sometimes-considered-a-bad-thing#comment138572595_547760)
  https://eli.thegreenplace.net/2009/02/16/abstract-vs-concrete-syntax-trees
  > The pointer is now clearly below the array
  i.e. [array of pointers](https://stackoverflow.com/q/6130712/21294350) as expected.
- > e problem arises from the possibility of confusion between the names used for the formal parameters of a procedure and the (possibly identical) names used in the expressions to which the procedure may be applied
  i.e. local compared with global
```scheme
(define (f x) (* x x))
(define x 10)
(f (+ x x))
```
- TODO
  - > Indeed, there is a *long history* of erroneous definitions of substitution in the literature of logic and programming semantics.
  - > prove for procedure applications that can be modeled using substitution (includ-ing all the procedures in the first two chapters of this book) and that yield legitimate values, normal-order and applicative-order evaluation *produce the same value*.
  - https://softwareengineering.stackexchange.com/a/186255
    > because normal-order evaluation becomes much more complicated to deal with when we leave the realm of procedures that can be modeled by substitution.
    notice "special form" may be [neither of applicative or normal][how_special_form_is_special].
- [clause](https://www.merriam-webster.com/dictionary/clause) different from that in logic.
- [so-called very high-level languages](https://en.wikipedia.org/wiki/Declarative_programming) which seems to be learned in COD.
- [antilogarithm](https://mathworld.wolfram.com/Antilogarithm.html) is just exp
- > Such a name is called a bound variable, and we say that the procedure definition binds its formal parameters.
  i.e. its value [has range](https://en.wikipedia.org/wiki/Free_variables_and_bound_variables)
  > if the value of that variable symbol has been bound to a specific value or range of values in the domain of discourse or universe.
- [consistent_renaming]
  - [capture-avoiding substitution](https://stackoverflow.com/a/11332661/21294350)
    i.e. as the book says
    > It would have changed from free to bound
  - An5Drama's question
    2: here $z$ won't exist in $t,e,y$, so it is safe to replace (i.e. "a *fresh* name"). More detailed about "free" see the book.
- [lexical scoping](https://www.shecodes.io/athena/9740-what-is-lexical-scoping-and-how-does-it-work-in-javascript#:~:text=Lexical%20scoping%20is%20a%20way,interact%20with%20examples%20in%20JavaScript.) just means child scope can use all variables defined in the parent scope but not vice versa.
- > the simplest name-packaging problem
  i.e. to [package the function](https://stackoverflow.com/a/20520767/21294350).
  > better structuring a procedure, not for efficiency
  - Also see [this with one ASCII figure](https://veliugurguney.com/blog/post/sicp_7_-_sections_1.1.6_1.1.7_1.1.8)
#### 1.1.4
- "Compound Procedures" is compared with *primitive* procedures.
### 1.2 (Here I read it first to check why CS 61A Week 2 chooses Section 1.3)
IMHO it is fine to read 1.2 without reading 1.3 first.
- footnote 30 is trivial if having learnt computer architecture.
- tail-recursive
  - [naming source](https://stackoverflow.com/a/33930/21294350)
    > In tail recursion, you perform your calculations first, and then you execute the recursive call,
    Also see comment [1](https://stackoverflow.com/questions/33923/what-is-tail-recursion#comment18950582_37010) which is same as book
    > In this case there is some additional “hidden” information, maintained by the interpreter and *not contained in the program variables*, which indicates “where the process is” in negotiating the chain of deferred operations
    - TODO what does [this](https://stackoverflow.com/questions/33923/what-is-tail-recursion#comment30739771_37010) mean since with `else` removed then the call disappears.
      > It would have been more clearly a tail call, if the "else:" were omitted. Wouldn't change the behavior, but would place the tail call as an independent statement
      [tail call](https://stackoverflow.com/questions/12045299/what-is-difference-between-tail-calls-and-tail-recursion#comment16081995_12045299)
- > us, the process uses a number of steps that grows exponentially with the input.
  See [this][Fib_complexity] 
  If seeing it as the binary tree, $O(2^n)$ is trivial. More specifically, the deepest leef is the path following $(fib (- n 1))$ up to 1. So the maximum node number is the maximum time complexity (trace back from the leaf, due to `+ O(1)` each node contributes `O(1)` time. Then the time complexity is `O(1)*node_num`) $(2^0+\ldots+2^{n-1})\cdot O(1)=(2^n-1)\cdot O(1)$.
  More strictly, we can let $k=O(1)$, then just solve the recurrence relation.
  - TODO
    - meaning of
      > If you could *reach out toward infinity* it would get close to O(golden_ratio^n). That is what an asymptote is, the distance between the two lines must approach 0.
      - "the distance between the two lines must approach 0" may mean the tree is so big so that the edge distance is samll if put the tree on the paper.
    - Here depth should be [$n-1$](https://stackoverflow.com/a/2603707/21294350) since the tree is from n to 1.
- > because we need keep track only of which nodes are above us in the tree at any point in the computation.
  Here is based on applicative order. See Figure 1.5.
  In a summary for each node, we only keep the path from it to the root as the stack and will pop & push the stack when moving from the left leaf to the right.
- In summary of the previous 2 points
  > In general, the number of steps required by a tree-recursive process will be propor-tional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree.
- > one linear in n, one growing as fast as Fib(n) itself
  Compared with Figure 1.3, here we duplicately calculate many terms so `Fib(n)` with exponential time complexity.
  But the space complexity of these 2 problems are same due to no **redundancy**.
  Also see [Fib_complexity]
  > This is assuming that repeated evaluations of the same Fib(n) take the same time
  - > An example of this was hinted at in Section 1.1.3. e interpreter itself evaluates expressions using a tree-recursive process.
    TODO Here no redundancy, so we need to always use one tree to represent the data.
- > To formulate the iterative algorithm required noticing
  should be "requires" by [this](https://qr.ae/pslucp)
  > To do what needs to be done, regardless of what one wants to do, *depends* upon discipline, not motivation.
- > e number of ways to change amount a using n kinds of coins equals
  This has been learned in DMIA.
  - > changing smaller amounts using fewer kinds of coins
    here should be "or using ...".
    where the former corresponds to $a-d$ and the latter corresponds to "all but the first kind of coin".
  - > For example, work through in detail how the reduction rule applies to the problem of making change for 10 cents using pennies and nickels.
    let $A(n)$ -> only use pennies
    $B(n)$ -> use pennies and nickels.
    Then $B(10)=A(10)+B(5)=A(10)+A(5)+B(0)=A(10)+A(5)+A(0)+B(-5)$
    Here $B(0)=1$ because it already chooses 2 nickels.
    Trivially, to choose 0 cents, using what kinds of coins doesn't matter.
    - > If n is 0, we should count that as 0 ways to make change.
      This is trivial since we have no money so impossible "to make change".
  - "first-denomination" chooses the biggest to accelerate the recursion.
  - > count-change generates a tree-recursive process with redundancies sim-ilar to those in our first implementation of fib
    Here either the 1st param (unfixed decrease amount) or the 2nd (fixed decrease amount) is decreased, so reordering the decrease sequence and then add some decreases due to "unfixed decrease amount" *may* cause the same state.
- > the analysis of a process can be carried out at various *levels of abstraction*.
  See CS 61A notes.
- > We can compute exponentials in fewer steps by using successive squaring.
  This is already said in DMIA "ALGORITHM 4 Recursive Modular Exponentiation.".
  Iterative see "ALGORITHM 5 Fast *Modular* Exponentiation." and mcs "6.3.1 Fast Exponentiation".
  Although they are for *Modular* Exponentiation.
  - In a summary `xy` in mcs just counts the corresponding $1000\ldots 0$. 
    Or we can see each `x` as the *minimum unit* after `quotient(z,2)`. So `xy` will count that minimum unit.
    `z = 0` means we have counted all bits.
- See **footnote** 37 for a *precise* calculation of the complexity.
  - > equal to 1 less than the log base 2 of n
    IMHO here should be $\lfloor \log_2 n\rfloor$ instead of $\log_2 n - 1$.
    For example, $10\xRightarrow{s(quare)}1\xRightarrow{*}0$ so $2=\log_2(0b10)$ multiplications
    Then $11\xRightarrow{*}10\ldots$ so add 1 due to one 1 for the *odd* case.
    > is total is always less than twice the log base 2 of n.
    the num of 1 is at most $\lceil \log_2 n\rceil$.
    So total is $\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil<2(\log_2 n+1)$.
    Notice if $frac(\log_2 n)<0.5$, then the above is bigger than $2\log_2 n$.
    - $\lfloor \log_2 n\rfloor$ can be intuitively seen as square-rooting the number until the leading 1 is left.
      While $\lceil \log_2 n\rceil$ will go one more step to count the bit digit number.
    - since $R(n)\in [\overbrace{\lfloor \log_2 n\rfloor+1}^{1000\ldots 000},\lfloor \log_2 n\rfloor+\lceil \log_2 n\rceil]\Rightarrow R(n)=\Theta(\log n)$
    - Also see "Exercise_1_16.rkt" comment.
    - ~~Notice we ignores the multiplication in `square`.~~
- > For example, fast-expt for n = 1000 re-quires only 14 multiplications
  See fast-expt.scm the above should be `15=import math;bin(1000).count('1')+math.floor(math.log(1000,2))`.
- [Chandah-sutra by Áchárya Pingala](https://rarebooksocietyofindia.org/postDetail.php?id=196174216674_480588701674)
- > is generates an iterative process, whose number of steps grows as the logarithm of the numbers involved.
  See [this](https://stackoverflow.com/a/3981010/21294350)
  - Tiny A: `b % (a % b)=b%a<a`
    to prove $\frac{\frac{b}{2}}{a+b}>\frac{1}{4}$, i.e. prove $2b>a+b\Rightarrow b>a$ which is trivial.
  - > Input size N is lg(A) + lg(B)
    strictly "the number of input digits" is $\lceil\log A\rceil$
  - I skipped the last 2 sentences since they are not directly about gcd.
- > because it appears in Euclid’s Elements (Book 7, ca. 300 ..)
  [See](http://aleph0.clarku.edu/~djoyce/java/elements/bookVII/propVII2.html)
- > since q must be at least 1
  because $a_k>b_k$
- Lamé’s Theorem is already proved in mcs.pdf (TODO location)
- > Hence, the order of growth is Θ(log n)
  [see](https://stackoverflow.com/questions/3980416/time-complexity-of-euclids-algorithm#comment138640494_3980416)
- > r will have order of growth √Θ( n)
  i.e. consider the worst case.
- `(expmod base exp m)` is based on [modulus multiplication](https://math.stackexchange.com/q/2416119/1059606) which is also said in footnote 46.
- > Considering an algorithm to be inadequate for the first reason but not for the second illustrates the difference between mathematics and engineering.
  [See](https://stackoverflow.com/questions/78641848/when-can-we-safely-use-the-randomized-algorithm-considering-probability#comment138650510_78641848)
- > if n passes the test for some random choice of a, the chances are better than even that n is prime. If n passes the test for two random choices of a, the chances are better than 3 out of 4 that n is prime.
  This [only holds when $P(A)=\frac{1}{2}$](https://math.stackexchange.com/a/3363464/1059606)
  - I skipped the [more precise calculation](https://math.stackexchange.com/questions/3363141/probability-that-a-number-passing-the-fermat-test-is-prime#comment6922489_3363141) and [this](https://t5k.org/prove/prove2_3.html) (SkipMath).
    > It has been proven ([Monier80] and [Rabin80]) that the strong probable primality test is wrong no more than 1/4th of the time (3 out of 4 numbers which pass it will be prime)
- "information retrieval" is mainly about private information.
- > ``probabilistic'' algorithm with order of growth $\Theta(\log n)$
  It only counts `expmod` and if for `fast-prime?` we use `n-1` times then the "order of growth" is worse $\Theta(n\log n)$.
### 1.3
- [footnote 49](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-12.html#footnote_Temp_90)
  [proof](https://math.stackexchange.com/a/14817/1059606) using [Taylor series](https://en.wikipedia.org/wiki/Taylor_series#Trigonometric_functions) which is the most trivial.
  Also see [wikipedia](https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80#Proof_2) where I skipped studying about "Stolz angle".
- > e variables’ values are computed outside the let
  See [R5RS](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_6.html#IDX89)
  > The <init>s are evaluated *in the current environment* (in some unspecified order), the <variable>s are bound to *fresh locations* holding the results
  "fresh locations" implies the above
  - This is also implied its equivalence with `lambda` where `exp` trivially should *not influence with each other*.
#### 1.3.3
- > the number of steps required grows as Θ(log(L/T ))
  trivial by counting how many times we divide by 2.
- > f (x), f (f (x)), f (f (f (x))), ...,
  This can also find the "fixed point" if it exists.
  [See](https://math.stackexchange.com/a/9181/1059606)
  - [proof][Banach_fixed_point_proof]
    - Here T is continuous is due to https://en.wikipedia.org/wiki/Contraction_mapping -> https://en.wikipedia.org/wiki/Uniform_continuity#Definition_of_uniform_continuity
      notice "uniformly continuous" is for $(x,y)$ while (ordinary) continuity is for $x$
      - compared with [normal function](https://en.wikipedia.org/wiki/Continuous_function)
        > Continuity of real functions is usually defined *in terms of limits*. A function f with variable x is continuous at the real number c, if the *limit* of ${\displaystyle f(x),}$ as x tends to c, is equal to ${\displaystyle f(c).}$
        https://en.wikipedia.org/wiki/Limit_(mathematics)#In_functions is same as the above "Definition of (ordinary) continuity" where $d$ becomes absolute function $d(x,y)=|x-y|$.
    - The above is similar to the QA answer.
    - In summary it first
      > This proves that the sequence ${\displaystyle (x_{n})_{n\in \mathbb {N} }}$ is *Cauchy*
      then "completeness" (with Cauchy, we get the limit) -> "Furthermore" (existence) -> "Lastly" (unique)
      So we *only* need to prove "Cauchy sequence" and the rest all *follows*.
  - This question has one good wikipedia reference ([link at that time](https://en.wikipedia.org/w/index.php?title=Banach_fixed-point_theorem&oldid=363078964) proof is almost similar to the current one) but it asks how to calculate limit which is easy as the [top answer](https://math.stackexchange.com/a/9158/1059606) says.
- TODO
  - > not as far from y as x/y
    Here "average" should be "as far".
    - So interestingly and subtly, This intuitive average *still* holds one *reasonable* "fixed point" definition
    $\frac{1}{2}(y+x/y)=y\Rightarrow y=x/y$
      Then I read
      > (Note that y = 12 (y + x/y) is a simple transformation of the equation y = x/y; to derive it, add y to both sides of the equation and divide by 2.)
- > With this modification, the square-root procedure works.
  Here $y_0=1>0$ then $y_n>\sqrt{x},n\ge 1$
  Then 
  $$
  \begin{align*}
    y_{n+2}-y_{n+1}&=\frac{1}{2}[(y_{n+1}-y_{n})+\frac{x}{y_{n+1}}-\frac{x}{y_{n}}]\\
                   &=\frac{1}{2}(y_{n+1}-y_{n})(1+x\cdot(-\frac{1}{y_{n}y_{n+1}}))\\
                   &<\frac{1}{2}(y_{n+1}-y_{n})
  \end{align*}
  $$
  So it is one Cauchy sequence as [Banach_fixed_point_proof] shows (Here $||$ meets the 1st inequality $d(x_{m},x_{n})\leq d(x_{m},x_{m-1})+d(x_{m-1},x_{m-2})+\cdots +d(x_{n+1},x_{n})$).
  - Here the inequity is inappropriate to catch with python since no program knows where to stop scaling (even for human, we only at the last step know how to scale).
    ```python
    from sympy import symbols
    x, y = symbols('x y')
    from sympy import simplify
    next_y=lambda x,y: 1/2*(x/y+y)
    y_n=next_y(x,y)
    y_nn=next_y(x,y_n)
    for i in range(10):
      print(simplify((y_nn-y_n)/(y_n-y)))
      y=y_n
      y_n=y_nn
      y_nn=next_y(x,y_nn)
    ```
- > a technique we that we call average damping
  [See](https://stackoverflow.com/a/3863467/21294350) with one interesting analogy.
  > a brake to a pendulum
  - > But not every function has this property.
    since one is oscillating while the other is strictly decreasing.
  - Also see [this](https://math.stackexchange.com/a/3518585/1059606) for why choose average function.
- > to derive it, add y to both sides of the equation and divide by 2
  See exercise 1.45 zhihu link.
  Here although these 2 functions are not same, they have one shared intersection point.
#### 1.3.4
- `fixed-point` similar to `good-enough?` where the former cares about `(- y (/ x y))` and the latter is about `abs (- (square guess) x)`
  `average-damp` -> `average`
  `(/ x y)` -> `(/ x guess)`
- footnote 62
  - See [1](https://math.stackexchange.com/q/247567/1059606) and the [answer](https://math.stackexchange.com/a/247575/1059606) (similar to [this](https://math.stackexchange.com/questions/4268181/total-bits-of-accuracy-gained-per-iteration-with-newtons-method#comment8879730_4268181))
    - Notice libretexts only shows *the upper bound* have "double" relation. But $f'',f'$ are  dynamic, so the *exact* mapping process may not hold that property.
- > Now we’ve seen how higher-order procedures permit us to *manipulate these general methods* to create further abstractions.
  See
  1. > Procedures that *manipulate procedures* are called higher-order procedures.
  2. > We have here a compound procedure, which has been given the name square
     i.e. "compound procedure" -> `(define (⟨name⟩ ⟨formal parameters⟩) ⟨ body⟩)` in Scheme.
  3. 1.3.3 preface.
- > ey may be included in data structures.
  ~~This is not included in [wikipedia](https://en.wikipedia.org/wiki/First-class_citizen)~~
  ~~maybe it [means](https://en.wikipedia.org/wiki/First-class_citizen#History)~~
  - > There are *no other expressions involving procedures* or whose results are procedures
    [i.e.][First_class_citizen]
    > they always have to appear in person and can never be represented by *a variable or expression*
    - Notice this is a bit different from Robin Popplestone's definition.
  - The definition is shown in [this wikipedia entry with SICP as the reference](https://en.wikipedia.org/wiki/First-class_function)
    - TODO
      > type theory also uses first-class functions to model associative arrays and similar data structures.
    - notice there is [no strict definition][First_class_citizen]
      > He did not actually define the term strictly
### TODO
- > should note the remarks on “tail recursion” in Section 1.2.1.
## cs61a (read the *related reading* before reading the lecture as the above advises)
### 1.1
- [recursion equation](https://www.geeksforgeeks.org/recursion-in-lisp/)
- [quote diff list](https://stackoverflow.com/a/34984553/21294350) (I only read "A rule of thumb").
- the codes (e.g. 1.1/plural.scm) are pseudocode.
  - `bl` may probably mean butlast.
- >  the clauses aren’t invocations.
  i.e. not procedures.
- > BASIC doesn’t scale up
  maybe [due to](https://qr.ae/psm2OD)
  > More modern versions of BASIC are a lot more powerful, but they’ve lost sight of the original intent of the language. It *wasn’t even a structured language originally*.
- plumbing diagrams See COD FIGURE A.6.2.
- `se ` means [sentence](https://people.eecs.berkeley.edu/~bh/ssch5/words.html)
- map is [more general than function](https://en.wikipedia.org/wiki/Map_(mathematics)#:~:text=Maps%20as%20functions,-Main%20article%3A%20Function&text=In%20many%20branches%20of%20mathematics,%22%20in%20linear%20algebra%2C%20etc.)
- NOTICE 
  - `(zero (random 10))` differs for "Applicative order" and "Normal order".
    > Because it’s not a function
    i.e. `(random 10)` will output different values each time.
  - > But later in the semester we’ll see that sometimes normal order is more efficient.
    TODO
### 1.2
- Here as CS61AS says, we assume `sort` can sort the sequence from low to high correctly.
  ```scheme
  (insert (first sent)
    (sort (bf sent)) )))
  ```
  Then `(insert num sent)` -> `(insert num (bf sent))` just inserts the number at the correct position.
- > Well, if there are K numbers in the argument to insert, how many comparisons does it do? K of them.
How many times do we call insert? N times. But it’s a little tricky because each call to insert has a
different length sentence. The range is from 0 to N − 1.

  Here it means `sent` in `(insert num sent)` has K numbers.
  Based on the context of "The range is from 0 to N − 1.", here it means `sort` is called N times.
  And each `sort` calls `insert` which in turn calls smaller `insert`.
- kw
  This is not said explicitly in the book
  > That constant factor of 12 isn’t really very important, since we don’t really know what we’re halving—that is, we don’t know exactly how long it takes to do one comparison. ... but for an overall sense of the nature of the algorithm, what counts is the N 2 part.
- > ∃k, N | ∀x > N, |f (x)| ≤ k · |g(x)|
  This is wrong when
  > ${\displaystyle g(x)}$ be strictly positive for all large enough values of ${\displaystyle x}$.
  since it denotes $\mathcal{O}$
- Θ(1) time to search
  See [CLRS](https://stackoverflow.com/q/73218786/21294350)
- > Many other problems that are not explicitly about sorting turn out to require similar approaches
  IMHO as DMIA says, first sort then search.
- >  if the speed of your computer doubles, that just adds 1 to the largest problem size you can handle
  This is for $2^n$, $n!$ is much worse.
- > This program is very simple, but it takes Θ(2n) time! [Try some examples. Row 18 is already getting slow.]
  ~~becuase `else` part has the binary tree form.~~
  - See [this](https://stackoverflow.com/a/22026052/21294350)
    if we consider addition number instead of call,
    then `F(0, m) = F(n, 0) = 0`.
    Then `F(n, m) = f(n, m) - 1` which is guessed first and then verified.
    - "finite difference equation" -> `F(n, m) = 1 + F(n - 1, m) + F(n, m - 1)`
    - I didn't dig into the simplification using *Stirling approximation* which is a bit tedious but the steps hew to the line.
  - Also see [link2](https://stackoverflow.com/a/26229383/21294350)
    - > until k reaches 1 or n reaches n/2 in any recursive call
      it should be "k reaches 0"
      and these 2 cases mean the same when n is even.
    - > The value of C(n,k) and the number of calls of C(n,k), that return the value 1, are the same,
      This can be proved using induction where the hypothesis is just the above statement.
    - The above $C(n,k)\neq T(n,k)$.
  - Also see [this](https://stackoverflow.com/q/43232800/21294350) which calculates complexity *row by row*.
    - > This means that all the coëfficients in the Pascal triangle are formed by adding 1 as many times as the value of that coëfficient.
      same as link2.
    - [answer](https://stackoverflow.com/a/43239200/21294350)
      - > Big problem
        I think it is solved in question which gets the correct result 2^n as the comments indicated.
        > This results in a geometric series, which computes the sum of all 2^r for r going from 0 to n-1.
- ~~TODO here `(empty? (bf in))` may not work since `(bf '())` is invalid.~~
- `(se 1 (iter old-row ’(1)))` and `(se (+ (first in) (first (bf in))) out)`
  will put the 2nd to left at the the 2nd to right position since `out` are the rightmost elements.
  Due to symmetry, it works.
  - `(empty? (bf in))` will break when `in='(1)`
  - More readable one [see](http://community.schemewiki.org/?sicp-ex-1.12)
    > Off on a tangent having misread the question & skipping ahead a few chapters:
    1. `(null? (cdr prev)) (list 1)` -> ending 1
    2. `(= 1 (car prev)) (cons 1` starts with 1
    3. `else` the middle part
  - Assume `(nth col (pascal-row row))` is $\Theta(1)$ complexity as ["Θ(1) time to search" says](https://stackoverflow.com/a/37350500/21294350).
    - > This was harder to write, and seems to work harder, but it’s incredibly faster because it’s Θ(N 2 ).
      for each row $n$ indexed from 0, we calculate the middle part ($n-1$ additions)
      So we have $1+\ldots+n-1=\Theta(n^2)$ (Here we ignore the call expense since as csapp says the compiler may combine calls to avoid that expense) (Here trivially we only consider *large* $n$ by complexity)
      similar to [this](https://stackoverflow.com/a/32498795/21294350)
      ```java
      tempList.add(1);
      for(int j = 1; j < i; j++){
          tempList.add(pyramidVal.get(i - 1).get(j) + pyramidVal.get(i - 1).get(j -1));
      }
      if(i > 0) tempList.add(1);
      pyramidVal.add(tempList);
      ```
- > computes a few unnecessary ones
  i.e. at least the *other* terms at the target row.
### 1.3
- > the formal parameter list obviously isn’t evaluated, but the body isn’t evaluated when we see the lambda, either—only when we invoke the function can we evaluate its body.
  See exercise 1.6 notes where the arguments are evaluated first.
- If using [this definition](https://rosettacode.org/wiki/First-class_functions#:~:text=Since%20one%20can't%20create,C%20has%20second%20class%20functions.), C  doesn't have first-class functions since
  > Create new functions from preexisting functions *at run-time*
  is not met.
- > you’ll learn more about this in CS 164.
  It's about ["the design of programming languages and the implementation of translators"](https://web.archive.org/web/20200129153230/https://inst.eecs.berkeley.edu/~cs164/sp11/)
# chapter 2
## book
### 2.1
- > We now come to the decisive step of mathematical abstraction: we forget about what the symbols stand for. ...[The mathematician] need not be idle; there are many operations which he may carry out with these symbols, *without ever having to look at the things they stand for*.
  [original paper](https://sci-hub.se/https://www.jstor.org/stable/1666589). 
  TODO IMHO Here it just means we can manipulate with data without knowing about it.
  See
  > it is irrelevant what a, b, x, and y are and even more *irrelevant how they might happen to be represented in terms of more primitive data*
- > is will further blur the distinction between “procedure” and “data,” which was already becoming tenuous toward the end of chapter 1
  Since procedure can be the argument and the returned value.
- [closure](https://en.wikipedia.org/wiki/Closure_(mathematics)), i.e. codomain $\subseteq$ domain.
- data-directed programming is different from [Data-driven programming](https://en.wikipedia.org/wiki/Data-driven_programming)
  TODO how it is implemented?
# Colophon
- > is image of the engraving is hosted by J. E. Johnson of New Goland.
  [See](https://www.pinterest.com/newgottland/mechanisms/) -> [this](https://www.pinterest.com/pin/116108496617565759/)
- > e typefaces are Linux Libertine for body text and Linux Biolinum for headings, both by Philipp H. Poll
  [See](https://www.fontsquirrel.com/fonts/list/foundry/philipp-poll)
- [Inconsolata](https://fonts.google.com/?query=Raph+Levien) (Also see Alegreya) [LGC](https://online-fonts.com/fonts/inconsolata-lgc)
# TODO about the earlier chapters after reading later chapters
- > by incorporating a limited form of normal-order evaluation
# TODO after lambda calculus
- [consistent_renaming] An5Drama's question 3.
# TODO after numerical analysis (Most of applications in SICP are about numerical analysis)
- Why Newton’s method [only get to the local root](https://math.stackexchange.com/a/961171/1059606) but not global although intuitively it is that case.
  - Also see [one interesting problem](https://qr.ae/psBzi8)
## See TODO in exercise
- 1.45

TODO read Lecture 5,6 & 6.001 in perspective & The Magic Lecture in 6.037 which don't have corresponding chapters in the book. Also read [~~Lectures without corresponding sections~~](https://ocw.mit.edu/courses/6-001-structure-and-interpretation-of-computer-programs-spring-2005/pages/readings/) ([6.001 2007](https://web.archive.org/web/20161201165314/http://sicp.csail.mit.edu/Spring-2007/calendar.html) is almost same as 2005 and they are both taught by [Prof. Eric Grimson](https://orgchart.mit.edu/leadership/vice-president-open-learning-interim-and-chancellor-academic-advancement/biography)).

[ucb_sicp_review]:https://people.eecs.berkeley.edu/~bh/sicp.html

[course_note]:https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/course.html

[academia_se_tips]:https://academia.stackexchange.com/a/163476

[AI_preq_sicp]:https://functionalcs.github.io/curriculum/sicp.html

[mit_End_of_an_Era_comment]:https://mitadmissions.org/blogs/entry/the_end_of_an_era_1/#comment-31965

[how_special_form_is_special]:https://softwareengineering.stackexchange.com/a/137437

[consistent_renaming]:https://cs.stackexchange.com/a/97700/161388

[Fib_complexity]:https://stackoverflow.com/a/360773/21294350

[evernote_proof_1_13]:https://www.evernote.com/shard/s100/client/snv?noteGuid=6a4b59d5-e99f-417c-9ef3-bcf03a4efecd&noteKey=7e030d4602a0bef5df0d6dd4c2ad47bf&sn=https%3A%2F%2Fwww.evernote.com%2Fshard%2Fs100%2Fsh%2F6a4b59d5-e99f-417c-9ef3-bcf03a4efecd%2F7e030d4602a0bef5df0d6dd4c2ad47bf&title=Exercise%2B1.13

[Banach_fixed_point_proof]:https://en.wikipedia.org/wiki/Banach_fixed-point_theorem#Proof
[First_class_citizen]:https://en.wikipedia.org/wiki/First-class_citizen#History