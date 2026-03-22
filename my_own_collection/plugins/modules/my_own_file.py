#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_file
short_description: Создает текстовый файл
description: Этот модуль создает текстовый файл на указанном пути.
version_added: "1.0.0"
options:
    path:
        description: Путь к файлу для создания
        required: true
        type: str
    content:
        description: Содержимое файла
        required: false
        type: str
        default: ""
    state:
        description: Состояние файла
        required: false
        type: str
        choices: ['present', 'absent']
        default: 'present'
author: Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
- name: Создать файл
  netology.cloud_ansible.my_own_file:
    path: /tmp/config.txt
    content: "Привет из модуля!"
'''

RETURN = r'''
path:
    description: Полный путь к созданному файлу
    returned: always
    type: str
'''

from ansible.module_utils.basic import AnsibleModule
import os


def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=False, default=""),
        state=dict(type='str', required=False, default='present', 
                   choices=['present', 'absent'])
    )

    result = dict(changed=False, path='', state='')

    module = AnsibleModule(argument_spec=module_args, supports_check_mode=True)

    path = module.params['path']
    content = module.params['content']
    state = module.params['state']

    if module.check_mode:
        if state == 'present':
            result['changed'] = True
            result['path'] = path
        module.exit_json(**result)

    file_exists = os.path.exists(path)

    if state == 'absent':
        if file_exists:
            try:
                os.remove(path)
                result['changed'] = True
                result['state'] = 'absent'
            except Exception as e:
                module.fail_json(msg=f'Не удалось удалить: {e}', **result)
        else:
            result['state'] = 'absent'
        module.exit_json(**result)

    elif state == 'present':
        changed = False
        
        if file_exists:
            try:
                with open(path, 'r') as f:
                    current_content = f.read()
                if current_content != content:
                    changed = True
            except Exception:
                changed = True
        else:
            changed = True
            
        if changed:
            dir_path = os.path.dirname(path)
            if dir_path and not os.path.exists(dir_path):
                os.makedirs(dir_path)
            
            try:
                with open(path, 'w') as f:
                    f.write(content)
                result['changed'] = True
            except Exception as e:
                module.fail_json(msg=f'Ошибка при создании: {e}', **result)

        result['path'] = path
        result['state'] = 'present'

    module.exit_json(**result)


if __name__ == '__main__':
    run_module()
