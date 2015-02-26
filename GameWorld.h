#ifndef GameWorld_H
#define GameWorld_H

#include <iostream>
#include "Vector2D.h"
#include "Vehicle.h"
#include "utils.h"

class GameWorld
{
private:

    //local copy of client window dimensions
    int                           m_cxClient, m_cyClient;
    
    //a container of all the moving entities
    std::vector<Vehicle*>         m_Vehicles;
    
    //the position of the crosshair
    Vector2D                      m_vCrosshair;
    
    //set true to pause the motion
    bool                          m_bPaused;

public:

    GameWorld(int cx, int cy);

    ~GameWorld();

    void  update(double time_elapsed);

    void  render();

    const std::vector<Vehicle*>& Agents()
    {
        return m_Vehicles;
    }

    Vector2D    Crosshair()const{return m_vCrosshair;}
    void        SetCrosshair(Vector2D v);

    int   cxClient()const{return m_cxClient;}
    int   cyClient()const{return m_cyClient;}

    void        TogglePause(){m_bPaused = !m_bPaused;}
    bool        Paused()const{return m_bPaused;}
};

#endif