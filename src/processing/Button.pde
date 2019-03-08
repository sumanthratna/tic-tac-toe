class Button {
	private final color NORMAL = color(255);
	private String text;
	private int X, Y;
	private int width, height;
	private PShape rect;
	Button(int x, int y, int width, int height, String text) {
		this.text = text;
		this.X = x;
		this.Y = y;
		this.width = width;
		this.height = height;
		this.rect = createShape(RECT,this.X,this.Y,this.width,this.height);
		fill(NORMAL);
		shape(rect);
		drawButton();
		textFont(createFont("Courier New",24));
		textAlign(CENTER,CENTER);
		fill(0);
		text(this.text,(this.X+(this.X+this.width))/2,(this.Y+(this.Y+this.height))/2);
	}
	private void drawButton() {
		fill(NORMAL);
	}
	public void hide() {
		if (rect==null) {
			return;
		}
		rect.setVisible(false);
		rect = null;
	}
}
