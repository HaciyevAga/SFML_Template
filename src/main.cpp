#include <SFML/Graphics.hpp>
#include <iostream>

int main()
{
    const int wwight = 640;
    const int wheight = 480;
    float speed = 0.01f;
    sf::RenderWindow window(sf::VideoMode(wwight, wheight), "Game", sf::Style::Close);
    sf::CircleShape shape(50.f);
    shape.setFillColor(sf::Color::Cyan);
    shape.setPosition((window.getSize().x / 2.f) - shape.getRadius(), (window.getSize().y / 2.f) - shape.getRadius());

    sf::Font myfont;

    if (!myfont.loadFromFile("fonts/arial.ttf"))
    {
        std::cerr << "could not load font!\n";
        exit(-1);
    }

    sf::Text text("green circle", myfont, 15);
    text.setFillColor(sf::Color::Black);

    while (window.isOpen())
    {

        sf::Event event;
        while (window.pollEvent(event))
        {

            if (event.type == sf::Event::Closed)
                window.close();

            if (event.type == sf::Event::KeyPressed)
            {
                if (event.key.code == sf::Keyboard::X)
                {
                    speed *= -1;
                }
            }
        }

        shape.setPosition(shape.getPosition() + sf::Vector2f(speed, speed));
        text.setPosition(shape.getPosition() + sf::Vector2f(25, 25));

        window.clear();
        window.draw(shape);
        window.draw(text);
        window.display();
    }

    return 0;
}