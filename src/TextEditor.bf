using System;
using System.Collections;
using SDL2;
namespace CodeEditor;


class TextEditor
{
	String text = new String();
	int cursor;
	float x,y;
	String buffer = new String();

	public void AddText(String value){
		text.Append(value);
	}

	public void Backspace(){
		if(text.Length>0){
			text.RemoveFromEnd(1);
		}
	}

	public this(){
		this.cursor = 0;
	}

	public ~this(){
		delete text;
		delete buffer;
	}

	void DrawBuffer(){
		if(buffer.Length == 0){
			return;
		}
		int w;
		int h;
		gameApp.DrawString(gameApp.font, x, y, buffer, SDL.Color(0,100,255,255));
		SDLTTF.SizeText(gameApp.font.mFont, buffer, out w, out h);
		x+=w;
		buffer.Clear();
	}

	public void Draw(){
		x = gameApp.lineSize;
		y = gameApp.lineSize;

		for(var i=0;i<text.Length;i++){
			if(text[i] == '\n'){
				DrawBuffer();
				x = gameApp.lineSize;
				y+= gameApp.lineSize;
			}
			else{
				buffer.Append(text[i]);
			}
		}
		DrawBuffer();
	}
}