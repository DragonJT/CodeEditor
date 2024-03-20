using System;
using SDL2;
using System.Collections;

namespace CodeEditor
{
	static{
		public static GameApp gameApp;
	}

	class GameApp : SDLApp
	{
		public Font font = new Font();
		public int fontSize = 24;
		public int lineSize = (int)(fontSize*1.2f);
		public float spaceLength = fontSize*0.7f;
		TextEditor editor = new TextEditor();

		public this()
		{
			gameApp = this;
		}

		public ~this()
		{
			delete font;
			delete editor;
		}

		public override void Init()
		{
			base.Init();
			font.Load("Fonts/CourierPrime-Regular.ttf", 24);
		}

		public override void Draw()
		{
			SDL.SetRenderDrawColor(mRenderer, 200, 200, 200, 255);
			SDL.RenderClear(mRenderer);
			editor.Draw();
		}

		public override void KeyDown(SDL.KeyboardEvent evt)
		{
			if(evt.keysym.sym == .BACKSPACE){
				editor.Backspace();
			}
			else if(evt.keysym.sym == .RETURN){
				editor.AddText("\n");
			}
		}

		public override void HandleEvent(SDL.Event evt){
			if(evt.type == SDL.EventType.TextInput){
				String text = scope String();
				for(var i=0;i<32;i++){
					if(evt.text.text[i]==0){
						break;
					}
					text.Append((char8)evt.text.text[i]);
				}
				editor.AddText(text);
			}
		}

		public override void Update()
		{
			Render();
		}
	}
}
