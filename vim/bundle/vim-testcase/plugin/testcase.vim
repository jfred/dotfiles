function! FindParameter(expr, para)
    let regmid = '.*[    ;]' . a:para . ':[ ]*\(.\{-}\);.*'
    let regend = '.*[    ;]' . a:para . ':[ ]*\(.*\)'
    if a:expr =~ regmid
        return substitute(a:expr, regmid, '\1', '')
    elseif a:expr =~ regend
        return substitute(a:expr, regend, '\1', '')
    endif
    return ''
endfunc

function! JumpToTestCase()
    let testcase = FindParameter(getline(1), 'test-case-name')
    if !strlen(testcase)
        let testcase = FindParameter(getline(2), 'test-case-name')
    endif
    if strlen(testcase)
        "execute ":e " . testcase
        "echo testcase
        "execute ":py pyopener.open('" . testcase . "')"
        let file  = execute ":python import os.path as _, " . testcase . "; return _.dirname(_.realpath(" . testcase . ".__file__[:-1]))'"
        echo file
    else
        echo "test-case-name not specified"
    endif
endfunc

