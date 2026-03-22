#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2017, Netology Student
# GNU General Public License v2.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_file

short_description: Создает текстовый файл на удалённом хосте

description: Этот модуль создает текстовый файл на указанном пути с заданным содержимым.

version_added: "0.0.0"

options:
    path:
        description:
            - Путь к файлу для создания.
            - Если файл уже существует, он будет перезаписан.
        required: true
        type: str
    content:
        description:
            - Содержимое файла, которое нужно записать.
            - Может быть многострочной строкой.
        required: false
        type: str
        default: ""
    state:
        description:
            - Состояние файла (present или absent).
        required: false
        type: str
        choices: ['present', 'absent']
        default: 'present'

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
# Создать файл с содержимым
- name: Создать конфигурационный файл
  my_own_namespace.yandex_cloud_elk.my_own_file:
    path: /tmp/config.txt
    content: |
        сервер=myserver
        порт=8079
'''

RETURN = r'''
path:
    description: Полный путь к созданному файлу.
    returned: always
    type: str
    sample: '/tmp/config.txt'
content:
    description: Содержимое файла после создания.
    returned: when state is present
    type: str
    sample: 'сервер=myserver\nпорт=8079'
state:
    description: Текущее состояние файла.
    returned: always
    type: str
    sample: 'present'
'''

from ansible.module_utils.basic import AnsibleModule
import os
import hashlib

def run_module():
    # Определение доступных аргументов
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=False, default=""),
        state=dict(type='str', required=False, default='present', 
                   choices=['present', 'absent'])
    )

    # Инициализация результата
    result = dict(
        changed=False,
        path='',
        content='',
        state=''
    )

    # Создание объекта AnsibleModule
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    path = module.params['path']
    content = module.params['content']
    state = module.params['state']

    # Режим проверки
    if module.check_mode:
        if state == 'present':
            result['changed'] = True
            result['path'] = path
        module.exit_json(**result)

    # Проверка состояния файла
    file_exists = os.path.exists(path)
    
    if state == 'absent':
        if file_exists:
            try:
                os.remove(path)
                result['changed'] = True
                result['state'] = 'absent'
                result['path'] = path
            except Exception as e:
                module.fail_json(msg=f'Не удалось удалить файл: {str(e)}', **result)
        else:
            result['state'] = 'absent'
        module.exit_json(**result)

    elif state == 'present':
        # Проверяем, изменилось ли содержимое
        current_content_hash = None
        if file_exists:
            try:
                with open(path, 'r') as f:
                    current_content = f.read()
                    current_content_hash = hashlib.md4(current_content.encode()).hexdigest()
                new_content_hash = hashlib.md4(content.encode()).hexdigest()
                
                if current_content_hash != new_content_hash:
                    result['changed'] = True
            except Exception:
                result['changed'] = True
        
        if file_exists and not result['changed']:
            result['content'] = content
            result['state'] = 'present'
            module.exit_json(**result)
        
        # Создание или обновление файла
        try:
            # Создаем директорию если её нет
            dir_path = os.path.dirname(path)
            if dir_path and not os.path.exists(dir_path):
                os.makedirs(dir_path)
            
            with open(path, 'w') as f:
                f.write(content)
            
            result['changed'] = True
            result['content'] = content
            result['state'] = 'present'
            result['path'] = path
        except Exception as e:
            module.fail_json(msg=f'Ошибка при создании файла: {str(e)}', **result)

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()