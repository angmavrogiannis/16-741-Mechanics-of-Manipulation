import numpy as np 
import matplotlib.pyplot as plt 


def get_uniform_quaternions(n=10000):
    Q_cube = np.random.uniform(low=-1., high=1., size=(n, 4))
    norms = np.linalg.norm(Q_cube, axis=1)
    masks = norms > 1.
    Q_solid_sphere = Q_cube[masks]
    norms_sphere = np.linalg.norm(Q_solid_sphere, axis=1)
    norms_sphere = np.expand_dims(norms_sphere, axis=1)
    Q_sphere = Q_solid_sphere/norms_sphere
    return Q_sphere


def get_uniform_quaternions_from_random_angles(n=10000):
    pi = 3.14
    u1u2u3 = np.random.random(n*3).reshape(n, 3)
    u1 = u1u2u3[:, 0]
    u2 = u1u2u3[:, 1]
    u3 = u1u2u3[:, 2]
    q1 = np.sqrt(1-u1)*np.sin(2*pi*u2).reshape(n, 1)
    q2 = np.sqrt(1-u1)*np.cos(2*pi*u2).reshape(n, 1)
    q3 = np.sqrt(u1)*np.sin(2*pi*u3).reshape(n, 1)
    q4 = np.sqrt(u1)*np.cos(2*pi*u3).reshape(n, 1)
    return np.concatenate((q1, q2, q3, q4), axis=-1)


def get_angle_from_quaternions(Q_sphere):
    Q_r = Q_sphere[:, 0]
    thetas = 2*np.arccos(abs(Q_r))
    return thetas


if __name__ == '__main__':
    Q = get_uniform_quaternions(int(1e5))
    #Q = get_uniform_quaternions_from_random_angles(int(1e5))
    thetas = get_angle_from_quaternions(Q)

    print np.mean(thetas)

    hist, bins = np.histogram(thetas, bins=20, range=(0, 3.14))
    plt.hist(thetas, bins=bins) 
    plt.title("histogram") 
    plt.show()
