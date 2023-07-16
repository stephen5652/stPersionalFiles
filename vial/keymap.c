#include QMK_KEYBOARD_H
#include "version.h"

enum layer_names {
    QRTY,      // qwerty above workman to make sure transparent does not catch unwanted keycode
    QRTY_F,    // symbols
    DEFAULT_2, // media keys
    // DEFAULT_3,  // media keys
    SYSCONTROL, // added extra layer for via
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* Keymap 0: Basic layer
     *
     * ,--------------------------------------------------.           ,--------------------------------------------------.
     * |   =    |   1  |   2  |   3  |   4  |   5  | LEFT |           | RIGHT|   6  |   7  |   8  |   9  |   0  |   -    |
     * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
     * | Del    |   Q  |   W  |   E  |   R  |   T  |  L1  |           |  L1  |   Y  |   U  |   I  |   O  |   P  |   \    |
     * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
     * | BkSp   |   A  |   S  |   D  |   F  |   G  |------|           |------|   H  |   J  |   K  |   L  |; / L2|' / Cmd |
     * |--------+------+------+------+------+------| Hyper|           | Meh  |------+------+------+------+------+--------|
     * | LShift |Z/Ctrl|   X  |   C  |   V  |   B  |      |           |      |   N  |   M  |   ,  |   .  |//Ctrl| RShift |
     * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
     *   |Grv/L1|  '"  |AltShf| Left | Right|                                       |  Up  | Down |   [  |   ]  | ~L1  |
     *   `----------------------------------'                                       `----------------------------------'
     *                                        ,-------------.       ,-------------.
     *                                        | App  | LGui |       | Alt  |Ctrl/Esc|
     *                                 ,------|------|------|       |------+--------+------.
     *                                 |      |      | Home |       | PgUp |        |      |
     *                                 | Space|Backsp|------|       |------|  Tab   |Enter |
     *                                 |      |ace   | End  |       | PgDn |        |      |
     *                                 `--------------------'       `----------------------'
     */
    // If it accepts an argument (i.e, is a function), it doesn't need KC_.
    // Otherwise, it needs KC_*

    [QRTY] = LAYOUT_ergodox(KC_GRV, KC_1, KC_2, KC_3, KC_4, KC_5, KC_LEFT, KC_DEL, KC_Q, KC_W, KC_E, KC_R, KC_T, KC_EQUAL, LT(4, KC_CAPS), KC_A, KC_S, KC_D, KC_F, KC_G, KC_LSFT, KC_Z, KC_X, KC_C, KC_V, KC_B, KC_MINUS, KC_ESC, KC_NO, KC_LCTL, KC_LALT, KC_LGUI, TO(0), TO(1), KC_P0, KC_SPC, KC_BSPC, KC_ENT, KC_RGHT, KC_6, KC_7, KC_8, KC_9, KC_0, KC_BSPC, KC_LBRC, KC_Y, KC_U, KC_I, KC_O, KC_P, KC_BSLS, KC_H, KC_J, KC_K, KC_L, KC_SCLN, KC_QUOT, KC_RBRC, KC_N, KC_M, KC_COMM, KC_DOT, KC_SLSH, KC_RSFT, KC_RGUI, KC_RALT, KC_RCTL, KC_NO, OSM(MOD_RCTL | MOD_RALT | MOD_RGUI), KC_DOWN, KC_UP, KC_LEFT, KC_RGHT, KC_BSPC, KC_SPC), /* Keymap 1: Symbol Layer */
    // SYMBOLS
    [QRTY_F] = LAYOUT_ergodox(KC_TRNS, KC_F1, KC_F2, KC_F3, KC_F4, KC_F5, KC_F11, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, TO(0), TO(2), KC_P1, KC_TRNS, KC_TRNS, KC_TRNS, KC_F12, KC_F6, KC_F7, KC_F8, KC_F9, KC_F10, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
    /* Keymap 2: Media and mouse keys
     *
     * ,--------------------------------------------------.           ,--------------------------------------------------.
     * |        |      |      |      |      |      |      |           |      |      |      |      |      |      |        |
     * |--------+------+------+------+------+-------------|           |------+------+------+------+------+------+--------|
     * |        |      |      | MsUp |      |      |      |           |      |      |      |      |      |      |        |
     * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
     * |        |      |MsLeft|MsDown|MsRght|      |------|           |------|      |      |      |      |      |  Play  |
     * |--------+------+------+------+------+------|      |           |      |------+------+------+------+------+--------|
     * |        |      |      |      |      |      |      |           |      |      |      | Prev | Next |      |        |
     * `--------+------+------+------+------+-------------'           `-------------+------+------+------+------+--------'
     *   |      |      |      | Lclk | Rclk |                                       |VolUp |VolDn | Mute |      |      |
     *   `----------------------------------'                                       `----------------------------------'
     *                                        ,-------------.       ,-------------.
     *                                        |      |      |       |      |      |
     *                                 ,------|------|------|       |------+------+------.
     *                                 |      |      |      |       |      |      |Brwser|
     *                                 |      |      |------|       |------|      |Back  |
     *                                 |      |      |      |       |      |      |      |
     *                                 `--------------------'       `--------------------'
     */
    // MEDIA AND MOUSE
    [DEFAULT_2] = LAYOUT_ergodox(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, TO(0), TO(3), KC_P2, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

    // MEDIA AND MOUSE
    // [DEFAULT_3]  = LAYOUT_ergodox(KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, TO(0), TO(4), KC_P3, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),
    [SYSCONTROL] = LAYOUT_ergodox(KC_NO, LSA(KC_1), LSA(KC_2), LSA(KC_3), LSA(KC_4), LSA(KC_5), LCTL(KC_UP), KC_NO, KC_NO, KC_NO, KC_UP, LSA(KC_R), LSA(KC_T), LCTL(KC_LEFT), KC_NO, KC_NO, KC_LEFT, KC_DOWN, KC_RGHT, KC_NO, LSFT(KC_NO), KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, LCTL(KC_RGHT), KC_NO, KC_NO, OSM(MOD_LCTL), OSM(MOD_LALT), OSM(MOD_LGUI), TO(0), KC_NO, KC_P3, KC_NO, KC_NO, DB_TOGG, KC_NO, LSA(KC_6), LSA(KC_7), LSA(KC_8), LSA(KC_9), LSA(KC_0), KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, LSA(KC_P), KC_NO, KC_LEFT, KC_DOWN, KC_UP, KC_RGHT, KC_NO, KC_NO, KC_NO, LSA(KC_N), LSA(KC_M), KC_NO, KC_NO, KC_NO, KC_NO, OSM(MOD_RGUI), OSM(MOD_RALT), OSM(MOD_RCTL), KC_NO, KC_NO, KC_VOLD, KC_VOLU, KC_BRIU, KC_BRID, KC_NO, KC_NO)};

// Runs constantly in the background, in a loop.

// layer_state_t layer_state_set_user(layer_state_t state) {
//     ergodox_board_led_off();
//     ergodox_right_led_1_off();
//     ergodox_right_led_2_off();
//     ergodox_right_led_3_off();
//     switch (get_highest_layer(state)) {
//         case 1:
//             ergodox_right_led_1_on();
//             break;
//         case 2:
//             ergodox_right_led_2_on();
//             break;
//         case 3:
//             ergodox_right_led_3_on();
//             break;
//         default:
//             // none
//             break;
//     }
//     return state;
// }
