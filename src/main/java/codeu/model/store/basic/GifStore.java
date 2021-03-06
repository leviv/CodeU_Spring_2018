// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.store.basic;

import codeu.model.data.Gif;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.util.ArrayList;
import java.util.List;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class GifStore {

    /** Singleton instance of GifStore. */
    private static GifStore instance;

    /**
     * Returns the singleton instance of GifStore that should be shared between all servlet
     * classes. Do not call this function from a test; use getTestInstance() instead.
     */
    public static GifStore getInstance() {
        if (instance == null) {
            instance = new GifStore(PersistentStorageAgent.getInstance());
        }
        return instance;
    }

    /**
     * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
     *
     * @param persistentStorageAgent a mock used for testing
     */
    public static GifStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
        return new GifStore(persistentStorageAgent);
    }

    /**
     * The PersistentStorageAgent responsible for loading gifs from and saving gifs
     * to Datastore.
     */
    private PersistentStorageAgent persistentStorageAgent;

    /** The in-memory list of gifs. */
    private List<Gif> gifs;

    /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
    private GifStore(PersistentStorageAgent persistentStorageAgent) {
        this.persistentStorageAgent = persistentStorageAgent;
        gifs = new ArrayList<>();
    }

    /** Access the current set of gifs known to the application. */
    public List<Gif> getAllGifs() {
        return gifs;
    }

    /** Add a new gif to the current set of gifs known to the application. */
    public void addGif(Gif gif) {
        gifs.add(gif);
        persistentStorageAgent.writeThrough(gif);
    }

    /** Sets the List of gifs stored by this GifStore. */
    public void setGifs(List<Gif> gifs) {
        this.gifs = gifs;
    }
}