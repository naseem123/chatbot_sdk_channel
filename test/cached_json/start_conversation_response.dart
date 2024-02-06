Map data = {
  "data": {
    "messenger": {
      "app": {
        "newConversationBots": {
          "id": "2091",
          "name": "Regression Test",
          "scheduled_at": null,
          "settings": {
            "paths": [
              {
                "id": "3418f148-6c67-4789-b7ae-8fb3758a4cf9",
                "steps": [
                  {
                    "type": "messages",
                    "controls": {
                      "type": "ask_option",
                      "label": "Select the step you want to test",
                      "schema": [
                        {
                          "id": "0dc3559e-4eab-43d9-ab60-7325219a3f6f",
                          "label": "Formatted Messages",
                          "element": "button",
                          "path_id": "5bb40c1f-429d-4473-9578-52374c649395",
                          "next_step_uuid":
                              "adc182b5-07a4-4218-808a-c24c6350e9e1"
                        },
                        {
                          "type": "messages",
                          "controls": {
                            "type": "ask_option",
                            "schema": [
                              {
                                "id": "0dc3559e-4eab-43d9-ab60-7325219a3f6f",
                                "label": "write here",
                                "element": "button"
                              }
                            ]
                          },
                          "messages": [],
                          "step_uid": "30e48aed-19c0-4b62-8afa-9a0392deb0b8"
                        },
                        {
                          "id": "bab39d38-e687-4883-b682-8573a9c23f23",
                          "label": "Survey",
                          "element": "button",
                          "path_id": "e43a444c-0d0c-443d-8359-cd3388d60ad3",
                          "next_step_uuid":
                              "488da083-ec1d-43cb-915a-9ad870047cbb"
                        },
                        {
                          "id": "9ec5fef5-3e03-47cd-a969-3d82414c58d3",
                          "label": "Form",
                          "element": "button",
                          "path_id": "9cf61448-3058-4016-bf0d-d3406c998698",
                          "next_step_uuid":
                              "3c5a46da-43fc-4c8e-800c-509693ea0db6"
                        },
                        {
                          "id": "1b0fc2b4-a808-455b-9590-780f89840b05",
                          "label": "Enter input",
                          "element": "button",
                          "path_id": "800acc6e-34ba-4792-9699-9866951599b4",
                          "next_step_uuid":
                              "7741dfa5-bd13-4a81-98ea-243f4fc8d469"
                        },
                        {
                          "id": "6f3cf4fe-62b4-4ca2-a507-a679dbd0e6c1",
                          "label": "Assign to agent",
                          "element": "button",
                          "path_id": "722f81c1-cede-4e4d-8806-810d0c204c41",
                          "next_step_uuid":
                              "fc1f16e3-1e53-4b1a-8b18-2627aa9a47b3"
                        }
                      ],
                      "wait_for_input": true
                    },
                    "messages": [],
                    "step_uid": "30e48aed-19c0-4b62-8afa-9a0392deb0b8"
                  }
                ],
                "title": "start",
                "follow_actions": null
              },
              {
                "id": "5bb40c1f-429d-4473-9578-52374c649395",
                "steps": [
                  {
                    "type": "messages",
                    "messages": [
                      {
                        "app_user": {
                          "id": 1,
                          "kind": "agent",
                          "email": "bot@chasqik.com",
                          "display_name": "bot"
                        },
                        "html_content": "--***--",
                        "serialized_content":
                            "{\"blocks\":[{\"key\":\"9oe8n\",\"text\":\"Lorem Ipsum\",\"type\":\"header-one\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"b7a1a\",\"text\":\"What is Lorem Ipsum?\",\"type\":\"header-three\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"d3udn\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"f5pt3\",\"text\":\"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\",\"type\":\"unordered-list-item\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":11,\"style\":\"BOLD\"},{\"offset\":334,\"length\":22,\"style\":\"ITALIC\"},{\"offset\":524,\"length\":25,\"style\":\"UNDERLINE\"}],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}"
                      }
                    ],
                    "step_uid": "adc182b5-07a4-4218-808a-c24c6350e9e1"
                  },
                  {
                    "type": "messages",
                    "messages": [
                      {
                        "app_user": {
                          "id": 1,
                          "kind": "agent",
                          "email": "bot@chasqik.com",
                          "display_name": "bot"
                        },
                        "html_content": "--***--",
                        "serialized_content":
                            "{\"blocks\":[{\"key\":\"9oe8n\",\"text\":\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\",\"type\":\"blockquote\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}"
                      }
                    ],
                    "step_uid": "2e073dc8-779c-453c-bf3e-02ac1a1df6b6"
                  },
                  {
                    "type": "messages",
                    "controls": {
                      "type": "ask_option",
                      "schema": [
                        {
                          "id": "3eadd82d-d782-4629-888e-54608258c793",
                          "label": "Back",
                          "element": "button",
                          "path_id": "3418f148-6c67-4789-b7ae-8fb3758a4cf9",
                          "next_step_uuid":
                              "30e48aed-19c0-4b62-8afa-9a0392deb0b8"
                        }
                      ]
                    },
                    "messages": [],
                    "step_uid": "4b56ede1-0f80-4541-bbc2-dbd232974c90"
                  }
                ],
                "title": "formatted-messages",
                "follow_actions": null
              },
              {
                "id": "9cf61448-3058-4016-bf0d-d3406c998698",
                "steps": [
                  {
                    "controls": {
                      "type": "app_package",
                      "schema": [
                        {
                          "type": "content",
                          "items": [
                            {
                              "hint": "Enter you name or nickname",
                              "name": "name",
                              "label": "Name",
                              "optional": "",
                              "placeholder": "John Doe"
                            },
                            {
                              "hint": "YYYY-MM-DD",
                              "name": "date_of_birth",
                              "label": "Date of Birth",
                              "optional": "on",
                              "placeholder": "2000-01-01"
                            },
                            {
                              "hint": "###-###-####",
                              "name": "phone",
                              "label": "Phone number",
                              "optional": "on",
                              "placeholder": ""
                            },
                            {
                              "hint": "Enter a valid postal code",
                              "name": "postal",
                              "label": "Postal Code",
                              "optional": "on",
                              "placeholder": ""
                            }
                          ]
                        }
                      ],
                      "app_package": "Qualifier"
                    },
                    "messages": [],
                    "step_uid": "3c5a46da-43fc-4c8e-800c-509693ea0db6"
                  },
                  {
                    "type": "messages",
                    "controls": {
                      "type": "ask_option",
                      "schema": [
                        {
                          "id": "6700f100-057e-42e1-b339-34aedce4d296",
                          "label": "Back",
                          "element": "button",
                          "path_id": "3418f148-6c67-4789-b7ae-8fb3758a4cf9",
                          "next_step_uuid":
                              "30e48aed-19c0-4b62-8afa-9a0392deb0b8"
                        },
                        {
                          "id": "599c78fc-d64a-4309-9b70-4212af7c0de5",
                          "label": "Close",
                          "element": "button",
                          "path_id": "26090be0-6721-420d-8a78-b6cc085451e9",
                          "next_step_uuid":
                              "88d482ae-1c82-46f2-8cd7-9bb6f2173b6e"
                        }
                      ],
                      "wait_for_input": true
                    },
                    "messages": [],
                    "step_uid": "12392c68-3ff1-4cec-831e-48fbef08f462"
                  }
                ],
                "title": "qualifier",
                "follow_actions": null
              },
              {
                "id": "e43a444c-0d0c-443d-8359-cd3388d60ad3",
                "steps": [
                  {
                    "type": "messages",
                    "messages": [
                      {
                        "app_user": {
                          "id": 1,
                          "kind": "agent",
                          "email": "bot@chasqik.com",
                          "display_name": "bot"
                        },
                        "html_content": "--***--",
                        "serialized_content":
                            "{\"blocks\":[{\"key\":\"9oe8n\",\"text\":\"Please complete below survey\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}"
                      }
                    ],
                    "step_uid": "488da083-ec1d-43cb-915a-9ad870047cbb"
                  },
                  {
                    "controls": {
                      "type": "app_package",
                      "schema": [
                        {
                          "text": "Experience Survey",
                          "type": "text",
                          "align": "center",
                          "style": "header"
                        },
                        {
                          "text":
                              "Click the button below to fill out the survey",
                          "type": "text",
                          "align": "center",
                          "style": "paragraph"
                        },
                        {
                          "id": "start-survey-192",
                          "name": "start-survey",
                          "type": "button",
                          "align": "center",
                          "label": "Start",
                          "action": {
                            "url": "/package_iframe_internal/Surveys",
                            "type": "frame"
                          },
                          "values": {
                            "language": "en",
                            "sender_id": 1187,
                            "template_title": "NPS",
                            "template_version_id": 192
                          },
                          "location": "messenger"
                        }
                      ],
                      "app_package": "Surveys"
                    },
                    "messages": [],
                    "step_uid": "34775bef-fab0-4984-9234-5f1d769b4259"
                  },
                  {
                    "type": "messages",
                    "controls": {
                      "type": "ask_option",
                      "schema": [
                        {
                          "id": "05c4bd56-8b11-46aa-bf28-16d8af58241d",
                          "label": "Back",
                          "element": "button",
                          "path_id": "3418f148-6c67-4789-b7ae-8fb3758a4cf9",
                          "next_step_uuid":
                              "30e48aed-19c0-4b62-8afa-9a0392deb0b8"
                        },
                        {
                          "id": "8bc70f70-f233-4d1b-b9cb-4cebe81425f7",
                          "label": "Close",
                          "element": "button",
                          "path_id": "26090be0-6721-420d-8a78-b6cc085451e9",
                          "next_step_uuid":
                              "88d482ae-1c82-46f2-8cd7-9bb6f2173b6e"
                        }
                      ],
                      "wait_for_input": true
                    },
                    "messages": [],
                    "step_uid": "75973c33-d04c-4bf2-b322-9aa0ab5bdaad"
                  }
                ],
                "title": "survey",
                "follow_actions": null
              },
              {
                "id": "800acc6e-34ba-4792-9699-9866951599b4",
                "steps": [
                  {
                    "type": "messages",
                    "messages": [
                      {
                        "app_user": {
                          "id": 1,
                          "kind": "agent",
                          "email": "bot@chasqik.com",
                          "display_name": "bot"
                        },
                        "html_content": "--***--",
                        "serialized_content":
                            "{\"blocks\":[{\"key\":\"9oe8n\",\"text\":\"Enter a text input:\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}"
                      }
                    ],
                    "step_uid": "7741dfa5-bd13-4a81-98ea-243f4fc8d469"
                  },
                  {
                    "type": "messages",
                    "controls": {"type": "wait_for_reply", "schema": []},
                    "messages": [],
                    "step_uid": "31eac700-d836-4460-ae47-9e3fbbd0ff0e"
                  },
                  {
                    "type": "messages",
                    "controls": {
                      "type": "ask_option",
                      "schema": [
                        {
                          "id": "eaf3c24e-4a3b-4c73-9d74-f1a4065b5fcc",
                          "label": "Back",
                          "element": "button",
                          "path_id": "3418f148-6c67-4789-b7ae-8fb3758a4cf9",
                          "next_step_uuid":
                              "30e48aed-19c0-4b62-8afa-9a0392deb0b8"
                        },
                        {
                          "id": "3c7f7c78-6914-4f27-b20d-c2ec35e4eb1b",
                          "label": "Close",
                          "element": "button",
                          "path_id": "26090be0-6721-420d-8a78-b6cc085451e9",
                          "next_step_uuid":
                              "88d482ae-1c82-46f2-8cd7-9bb6f2173b6e"
                        }
                      ],
                      "wait_for_input": true
                    },
                    "messages": [],
                    "step_uid": "bb9b493d-dcfc-49bf-8ec5-0dabcbdfcff5"
                  }
                ],
                "title": "user-input",
                "follow_actions": []
              },
              {
                "id": "722f81c1-cede-4e4d-8806-810d0c204c41",
                "steps": [
                  {
                    "type": "messages",
                    "messages": [
                      {
                        "app_user": {
                          "id": 1,
                          "kind": "agent",
                          "email": "bot@chasqik.com",
                          "display_name": "bot"
                        },
                        "html_content": "--***--",
                        "serialized_content":
                            "{\"blocks\":[{\"key\":\"9oe8n\",\"text\":\"This conversation will now be assigned\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}"
                      }
                    ],
                    "step_uid": "fc1f16e3-1e53-4b1a-8b18-2627aa9a47b3"
                  }
                ],
                "title": "assign",
                "follow_actions": [
                  {"key": "assign", "name": "assign_agent", "value": "3"}
                ]
              },
              {
                "id": "26090be0-6721-420d-8a78-b6cc085451e9",
                "steps": [
                  {
                    "type": "messages",
                    "messages": [
                      {
                        "app_user": {
                          "id": 1,
                          "kind": "agent",
                          "email": "bot@chasqik.com",
                          "display_name": "bot"
                        },
                        "html_content": "--***--",
                        "serialized_content":
                            "{\"blocks\":[{\"key\":\"9oe8n\",\"text\":\"Done!\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}"
                      }
                    ],
                    "step_uid": "88d482ae-1c82-46f2-8cd7-9bb6f2173b6e"
                  }
                ],
                "title": "close",
                "follow_actions": [
                  {"key": "close", "name": "close conversation", "value": null}
                ]
              }
            ],
            "bot_type": "new_conversations",
            "scheduling": "inside_office",
            "schedule_trigger": "regular_schedule",
            "schedule_trigger_holiday": "JU52QfJL6UgifwQ4FPG0t"
          },
          "scheduled_to": null
        }
      }
    }
  }
};
