if !has("python")
    finish
endif

hi NoCoverage ctermbg=gray guibg=#330000
hi SignColumn guibg=black ctermbg=NONE
sign define NoCoverage text=-- texthl=NoCoverage linehl=NoCoverage

function! Coverage()
    sign unplace *
    python <<END

import vim, os, subprocess

class Signs(object):

    def __init__(self):
        self.signid = 0
        self.bufferid = vim.eval('bufnr("%")')

    def place(self, lineno):
        self.signid += 1
        cmd = "sign place %d line=%d name=NoCoverage buffer=%s" % (self.signid, lineno, self.bufferid)
        vim.command(cmd)

def parse_coverage_output(output, filename):
    last_line = output.splitlines()[-1]
    filename_no_ext = os.path.splitext(filename)[0]
    signs = Signs()
    print last_line
    last_line = last_line[len(filename_no_ext) + 1:].lstrip()
    columns = last_line.split(None, 3)
    if len(columns) > 3:
        parse_lines(columns[3], signs)

def parse_lines(formatted_list, signs):
    for item in formatted_list.split(', '):
        if '-' in item:
            lo, hi = item.split('-')
        else:
            lo = hi = item
        lo, hi = int(lo), int(hi)
        for lineno in range(lo, hi+1):
            signs.place(lineno)

filename = vim.eval('bufname("%")')
if not os.path.exists('.coverage'):
    print 'No .coverage file'
else:
    output = subprocess.Popen(['coverage', '-rm', filename], stdout=subprocess.PIPE).communicate()[0]
    parse_coverage_output(output, filename)

END
endf

command! Coverage    call Coverage()
command! CoverageOff sign unplace *
