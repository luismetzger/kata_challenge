# Bank OCR

## Instructions
Work through each user story in sequence until you've completed each story or worked on the challenge for a maximum of two hours.  There's no expectation to complete all user stories; complete as much as you can within the time limit.

Once each story is completed or you've reached the two-hour limit, save your work and submit your solution.  You may upload your solution to GitHub and email a link to the repository or zip your work and email the zip file as an attachment.  Emails should be sent to bbergeron@performancehealthus.com.

After Performance Health Partners reviews your work, you may be invited to a follow-up meeting to discuss your solution.

## User Stories
### User Story 1: Parse Account Numbers
```
    _  _     _  _  _  _  _
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|

 _  _  _  _  _  _  _  _  _
| || || || || || || || || |
|_||_||_||_||_||_||_||_||_|

```
_Figure 1._ Example account number file with two entries.

You work for a bank that has recently purchased a machine that scans letters and faxes sent from branch offices for bank account numbers. The machine scans the paper documents and produces a file containing a list of account numbers (see Figure 1).  Each account number is written over 4 lines, and each line has 27 characters. The first 3 lines of each entry represent an account number written using pipes and underscores, and the fourth line is blank. Each account number should have 9 digits, all of which should be in the range 0-9. A normal file contains around 500 entries.

Write a program that parses one of these files into actual account numbers.

### User Story 2: Validate Account Numbers
```
account number: 345882865

position names:  d9  d8  d7  d6  d5  d4  d3  d2  d1
                 3   4   5   8   8   2   8   6   5

valid checksum calculation:
(d1 + 2 * d2 + 3 * d3 + ... + 9 * d9) mod 11 = 0
```
_Figure 2._ Explanation for how to calculate a checksum to validate an account number.

You realize that sometimes the scanning machine goes wrong in its scanning. The next step therefore is to validate that the numbers you read are in fact valid account numbers. A valid account number has a valid checksum, which can be calculated as shown in Figure 2.

Update your program to calculate the checksum for an account number and identify whether the account number is valid.

### User Story 3:  Export Account Numbers to File
```
457508000
664371495 ERR
86110??36 ILL
```
_Figure 3._ Example export file, containing a valid number, and invalid number, and a number with an illegible character.

Your boss is keen to see your results. He asks you to export a file of the scanned account numbers (see Figure 3).  You notice another issue: some digits in the scan are illegible.  Replace any illegible digits with a question mark (?). Note any invalid or illegible account numbers in the export.

Update your program to export the account numbers from the scanner-produced file to a new file.

### User Story 4:  Correct Invalid and Illegible Account Numbers
```
    _  _  _  _  _  _     _
|_||_|| || ||_   |  |  ||_
  | _||_||_||_|  |  |  | _|

```
_Figure 4._ Example scanned account number.

It turns out that often when a number comes back as invalid or with an illegible character it is because the scan is off by one pipe or one underscore for one of the figures.  In Figure 4, the 9 could be an 8 if a pipe is missing or a 5 if there's an extra pipe.  A 0 could be an 8 if an underscore is missing. Similarly, a 7 could be a 1 or the 1 could be a 7 and so on.

Your next task is to look at numbers that have come back as invalid or with an illegible character and try to guess what the account number should be by adding or removing just one pipe or underscore. If there is only one valid alternative account number, then use that alternative as the account number in the export. If there are multiple valid alternatives, the account number should be labelled "AMB" in the export file; otherwise, if there's no valid alternative continue to label numbers as "ERR" and "ILL".

Update your program to correct invalid and illegible account numbers where possible.

## Example Cases
### User Story 1
```
 _  _  _  _  _  _  _  _  _
| || || || || || || || || |
|_||_||_||_||_||_||_||_||_|

=> 000000000


  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |

=> 111111111

 _  _  _  _  _  _  _  _  _
 _| _| _| _| _| _| _| _| _|
|_ |_ |_ |_ |_ |_ |_ |_ |_

=> 222222222

 _  _  _  _  _  _  _  _  _
 _| _| _| _| _| _| _| _| _|
 _| _| _| _| _| _| _| _| _|

=> 333333333


|_||_||_||_||_||_||_||_||_|
  |  |  |  |  |  |  |  |  |

=> 444444444

 _  _  _  _  _  _  _  _  _
|_ |_ |_ |_ |_ |_ |_ |_ |_
 _| _| _| _| _| _| _| _| _|

=> 555555555

 _  _  _  _  _  _  _  _  _
|_ |_ |_ |_ |_ |_ |_ |_ |_
|_||_||_||_||_||_||_||_||_|

=> 666666666

 _  _  _  _  _  _  _  _  _
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |

=> 777777777

 _  _  _  _  _  _  _  _  _
|_||_||_||_||_||_||_||_||_|
|_||_||_||_||_||_||_||_||_|

=> 888888888

 _  _  _  _  _  _  _  _  _
|_||_||_||_||_||_||_||_||_|
 _| _| _| _| _| _| _| _| _|

=> 999999999

    _  _     _  _  _  _  _
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|

=> 123456789
```
_Figure 5._ Example cases for User Story 1.

### User Story 3
```
 _  _  _  _  _  _  _  _    
| || || || || || || ||_   |
|_||_||_||_||_||_||_| _|  |

=> 000000051

 _  _     _  _        _  _
|_ |_ |_| _|  |  ||_||_||_
|_||_|  | _|  |  |  | _| _|

=> 664371495 ERR

    _  _  _  _  _  _     _
|_||_|| || ||_   |  |  | _
  | _||_||_||_|  |  |  | _|

=> 49006771? ILL

    _  _     _  _  _  _  _
  | _| _||_| _ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _

=> 1234?678? ILL
```
_Figure 6._ Example cases for User Story 3.

### User Story 4
```

  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |

=> 711111111
 _  _  _  _  _  _  _  _  _
  |  |  |  |  |  |  |  |  |
  |  |  |  |  |  |  |  |  |

=> 777777177
 _  _  _  _  _  _  _  _  _
 _|| || || || || || || || |
|_ |_||_||_||_||_||_||_||_|

=> 200800000
 _  _  _  _  _  _  _  _  _
 _| _| _| _| _| _| _| _| _|
 _| _| _| _| _| _| _| _| _|

=> 333393333
 _  _  _  _  _  _  _  _  _
|_||_||_||_||_||_||_||_||_|
|_||_||_||_||_||_||_||_||_|

=> 888888888 AMB ['888886888', '888888880', '888888988']
 _  _  _  _  _  _  _  _  _
|_ |_ |_ |_ |_ |_ |_ |_ |_
 _| _| _| _| _| _| _| _| _|

=> 555555555 AMB ['555655555', '559555555']
 _  _  _  _  _  _  _  _  _
|_ |_ |_ |_ |_ |_ |_ |_ |_
|_||_||_||_||_||_||_||_||_|

=> 666666666 AMB ['666566666', '686666666']
 _  _  _  _  _  _  _  _  _
|_||_||_||_||_||_||_||_||_|
 _| _| _| _| _| _| _| _| _|

=> 999999999 AMB ['899999999', '993999999', '999959999']
    _  _  _  _  _  _     _
|_||_|| || ||_   |  |  ||_
  | _||_||_||_|  |  |  | _|

=> 490067715 AMB ['490067115', '490067719', '490867715']
    _  _     _  _  _  _  _
 _| _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|

=> 123456789
 _     _  _  _  _  _  _    
| || || || || || || ||_   |
|_||_||_||_||_||_||_| _|  |

=> 000000051
    _  _  _  _  _  _     _
|_||_|| ||_||_   |  |  | _
  | _||_||_||_|  |  |  | _|

=> 490867715
```
_Figure 7._ Example cases for User Story 4.
