import os

def main():
    build_content = None
    req_content = None

    with open(os.path.join('/app', 'requirements.txt'), 'r') as fi:
        req_content = fi.read().splitlines()
    
    # remove comments
    req_content = [x for x in req_content if '#' not in x]

    # unpin requirements
    req_content = list(map(lambda x: x.split('=')[0], req_content))

    # build deps list for BUILD
    build_req_content = list(map(lambda x: f'requirement("{x}")', req_content))

    with open(os.path.join('/app', 'BUILD'), 'r') as fi:
        build_content = fi.read()

    build_content = build_content.replace(';;', ',\n'.join(build_req_content))

    with open(os.path.join('/app', 'BUILD'), 'w') as fo:
        fo.write(build_content)

    with open(os.path.join('/app', 'requirements.txt'), 'w') as fo:
        fo.write('\n'.join(req_content))

if __name__ == "__main__":
    main()