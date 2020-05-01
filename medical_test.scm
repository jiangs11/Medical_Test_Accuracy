(define (medical_test Patient_Data)
        ; Main function
        (list (D_Pos1 Patient_Data)
              (D_Pos2 Patient_Data)
              (H_Neg1 Patient_Data)
              (H_Neg2 Patient_Data)
              (better_test Patient_Data)))

(define (D_Pos1 L)
        ; The probability that the patient has the disease, 
        ; given that the result of test 1 was positive.
        (/ (check_match_2and3_1s L) (count1s_3 L)))

(define (D_Pos2 L)
        ; The probability that the patient has the disease, 
        ; given that the result of test 2 was positive.
        (/ (check_match_2and4_1s L) (count1s_4 L)))

(define (H_Neg1 L)
        ; The probability that the patient does not have the disease,
        ; given that the result of test 1 was negative.
        (/ (check_match_2and3_0s L) (zeroes_test1 L)))

(define (H_Neg2 L)
        ; The probability that the patient does not have the disease, 
        ; given that the result of test 2 was negative.
        (/ (check_match_2and4_0s L) (zeroes_test2 L)))

(define (better_test L)
        ; Checks which test results was better, if there is one
        (cond ((and (> (D_Pos1 L)(D_Pos2 L))  (> (H_Neg1 L)(H_Neg2 L)))          'test1)
              ((and (> (D_Pos2 L)(D_Pos1 L))  (> (H_Neg2 L)(H_Neg1 L)))          'test2)
              (else 'neither)))
 
(define (check_match_2and3_1s L)
        ; Counts number of matching 1's in the 2nd and 3rd columns.
        (cond ((null? L)        0)
              ((and (eq? (cadar L) 1) (eq? (caddar L) 1))   (+ 1 (check_match_2and3_1s (cdr L))))
              (else (check_match_2and3_1s (cdr L)))))

(define (check_match_2and3_0s L)
        ; Counts number of matching 0's in the 2nd and 3rd columns.
        (cond ((null? L)        0)
              ((and (eq? (cadar L) 0) (eq? (caddar L) 0))   (+ 1 (check_match_2and3_0s (cdr L))))
              (else (check_match_2and3_0s (cdr L)))))

(define (count1s_3 L)
        ; Counts numbers of 1's in the Test1 Positive column.
        (cond ((null? L)           0)
              ((eq? (caddar L) 1)  (+ 1 (count1s_3 (cdr L))))
              (else (count1s_3     (cdr L)))))

(define (zeroes_test1 L)
        ; Counts number of 0's in the Test1 Positive column.
        ; Basically just 10 minus the number of 1's.
        (- (length L) (count1s_3 L)))

(define (check_match_2and4_1s L)
        ; Counts number of matching 1's in the 2nd and 3rd columns.
        (cond ((null? L)        0)
              ((and (eq? (cadar L) 1) (eq? (last (car L)) 1))   (+ 1 (check_match_2and4_1s (cdr L))))
              (else (check_match_2and4_1s (cdr L)))))

(define (check_match_2and4_0s L)
        ; Counts number of matching 1's in the 2nd and 3rd columns.
        (cond ((null? L)        0)
              ((and (eq? (cadar L) 0) (eq? (last (car L)) 0))   (+ 1 (check_match_2and4_0s (cdr L))))
              (else (check_match_2and4_0s (cdr L)))))

(define (count1s_4 L)
        ; Counts numbers of 1's in the Test2 Positive column.
        (cond ((null? L)            0)
              ((eq? (last (car L)) 1)   (+ 1 (count1s_4 (cdr L))))
              (else (count1s_4     (cdr L)))))

(define (zeroes_test2 L)
        ; Counts number of 0's in the Test2 Positive column.
        (- (length L) (count1s_4 L)))

(define (last L)
        ; Finds the last element of a list
        (cond ((null? L)          #f)
              ((null? (cdr L))    (car L))
              (else               (last (cdr L)))))

(medical_test '(
     (1   1   0   1)
     (2   1   1   0)
     (3   0   0   0)
     (4   0   0   1)
     (5   0   0   1)
     (6   0   0   0)
     (7   0   0   1)
     (8   0   1   1)
))