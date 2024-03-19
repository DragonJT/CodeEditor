using System;
using SDL2;
using System.Collections;

namespace CodeEditor
{
	class GameApp : SDLApp
	{
		Font font = new Font();

		public this()
		{
		}

		public ~this()
		{
			delete font;
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
			DrawString(font, 100, 100, "HelloWorld", .(0,0,0,255));
		}

		public override void KeyDown(SDL.KeyboardEvent evt)
		{
		}

		public override void Update()
		{
			Render();
		}
	}
}
