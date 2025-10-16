; ---------------------------------------------------------
; Count occurrences of a user-chosen character in:
;   Parangaricutirimicuaro
; Target: EMU8086 (DOS .COM)
; ---------------------------------------------------------

org 100h

WORD_LEN    EQU 22

start:
    ; ensure DS = CS (safe in .COM)
    push    cs
    pop     ds

    ; --- Show the fixed word --------------------------------
    mov     dx, OFFSET msg_word
    mov     ah, 09h
    int     21h

    ; --- Ask for the letter (single key) --------------------
    mov     dx, OFFSET msg_char
    mov     ah, 09h
    int     21h

get_key:
    mov     ah, 01h            ; read one key, echo
    int     21h
    cmp     al, 0Dh            ; ignore bare ENTER
    je      get_key
    mov     target, al

    ; newline before result
    mov     dx, OFFSET crlf
    mov     ah, 09h
    int     21h

    ; --- Count occurrences in the fixed word ----------------
    xor     bx, bx             ; BX = count = 0
    mov     si, OFFSET word
    mov     cl, WORD_LEN
    mov     al, target

count_loop:
    cmp     cl, 0
    je      show_result
    lodsb                      ; AL = [SI], SI++
    cmp     al, target
    jne     no_inc
    inc     bx
no_inc:
    dec     cl
    jmp     count_loop

; --- Show "Occurrences: " + decimal count -------------------
show_result:
    mov     dx, OFFSET msg_result
    mov     ah, 09h
    int     21h

    mov     ax, bx
    call    print_uint

    ; trailing CRLF and exit
    mov     dx, OFFSET crlf
    mov     ah, 09h
    int     21h

    mov     ax, 4C00h
    int     21h

; ---------------------------------------------------------
; print_uint
;   IN: AX = unsigned value (0..65535)
;   OUT: prints decimal to STDOUT (no leading zeros)
;   TRASHES: AX, BX, CX, DX
; ---------------------------------------------------------
print_uint PROC
    push    bx
    push    cx
    push    dx

    cmp     ax, 0
    jne     pu_nonzero
    mov     dl, '0'
    mov     ah, 02h
    int     21h
    jmp     pu_done

pu_nonzero:
    xor     cx, cx
pu_divloop:
    xor     dx, dx
    mov     bx, 10
    div     bx                 ; AX=AX/10, DX=remainder
    push    dx                 ; save digit
    inc     cx
    cmp     ax, 0
    jne     pu_divloop

pu_printloop:
    pop     dx
    add     dl, '0'
    mov     ah, 02h
    int     21h
    loop    pu_printloop

pu_done:
    pop     dx
    pop     cx
    pop     bx
    ret
print_uint ENDP

; -------------------- DATA --------------------------------
msg_word    db 13,10,'Word: Parangaricutirimicuaro',13,10,'$'
msg_char    db 'Press the LETTER to count (single key): $'
msg_result  db 13,10,'Occurrences: $'
crlf        db 13,10,'$'

target      db ?

word        db 'Parangaricutirimicuaro'  ; length = 22

; ---------------------------------------------------------
; End
; ---------------------------------------------------------
