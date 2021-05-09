#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Usage: xyz.py --stdin [--length] [--version] [--echoargs] [--json] [--stdout]

performs fzf + dynmenu xyz step. 

Options:
    -h --help  Show this Screen
    --version
    --length
"""

__version__="0.1"

## 命令 * * * \\
ls
`import sys
import subprocess
import json

from docopt import docopt
from dynmen import Menu

def readSTDIN():
    stdin_lines = []
    for line in sys.stdin:
        if line.strip() != "":
            stdin_lines.append(line.strip())

    return("\n".join(stdin_lines))

def dyfzfMenu(jqCMD):
    #exdict = {
    #    'SelectThis': ('ResultA', 'ResultB'),
    #    'SelectThat': ('ThatResultA', 'ThatResultB'),
    #}
    # exdict_json = json.dumps(exdict)
    # print(f'exdict_json {exdict_json}')
    if ('_syntax' in jqCMD):
        # this has a version, upgrade syntax 
        #match jqCMD['_syntax']:
        #    case "cmd": 
        #        pass
        #    case _: 
        #        print("🍒 no _syntax in exdict") 
        pass

    # 🍰 https://github.com/frostidaho/dynmen
    menu = Menu(['fzf']+jqCMD['fzf'])
    fzfResult = menu(jqCMD['exdict'])

    #print('Output from fzf:', out.selected)
    return fzfResult

    
def main():
    pass

if __name__ == '__main__':
    arguments = docopt(__doc__)

    jsonStr = ''
    if arguments['--version']:
        print(__version__)
        pass
    if arguments['--echoargs']:
        print(arguments)
        pass
    if arguments['--stdin']:
        jsonStr=readSTDIN()
    
    main()
    if arguments['--length']:
        print(len(jsonStr))
    else: 
        # todo: another source besides stdin. 
        pass

    # jq -> exdict
    # fromJQ = '{"Alyssa Boyd": ["Brownmouth", "09044"], "Candice Huber": ["New Kimberly", "11698"], "Dr. Kelli Sharp MD": ["North Rhondashire", "71761"], "Gary Hernandez": ["Burnshaven", "62267"], "Hannah Williams": ["North Stacy", "50983"], "Monique Mccoy": ["Katherinemouth", "42023"], "Trevor Kelly": ["South Jenniferport", "73366"]}'
    jqCMD = json.loads(jsonStr)
    fzfResult = dyfzfMenu(jqCMD)
    

    args = fzfResult[1]
    cmd = args.pop(0)
    print(json.dumps([cmd]+args))
    result = None
    if cmd == "python":
        result = subprocess.run(
            [sys.executable]+args, capture_output=True, text=True
        )
    elif cmd == "bash":
        result = subprocess.run(
            args, capture_output=True, text=True
        )


    if arguments['--json']:
        print(json.dumps(fzfResult))
        pass
    elif arguments['--stdout']:
        print(result.stdout)
        pass
    elif arguments['--stderr']: 
       print("stderr:", result.stderr)    
       pass
    else:
        print("try --json, --stdout")
